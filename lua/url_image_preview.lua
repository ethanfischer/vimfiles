-- Preview the image URL under the cursor in a floating window, drawn with the
-- Kitty graphics protocol (Ghostty, kitty). Everything stays in memory:
-- curl stdout -> ffmpeg stdin/stdout -> PNG string -> base64 -> terminal.
-- While the preview is open, + (or =) zooms in 10% and - zooms out.
--
-- Why not ImageMagick: `magick -` copies stdin to $TMPDIR/magick-XXXX before it
-- decodes PNG/JPEG/WebP. ffmpeg decodes from the pipe directly.
--
-- Why stderr: since Nvim 0.10 the TUI is a separate process and Lua runs in the
-- server. The server's stderr is inherited from the TUI, so it is the terminal.
-- (Nvim 0.12 adds nvim_ui_send() for this; 0.11 does not have it.)
local M = {}

local ffi = require('ffi')

local ESC = '\27'
local FIRST_IMAGE_ID = 4242
local CHUNK_SIZE = 4096
local TIOCGWINSZ = 0x40087468 -- macOS only
local ZOOM_STEP = 1.1
local ZOOM_KEYS = { ['+'] = 1, ['='] = 1, ['-'] = -1 }

if not pcall(function() return ffi.C.ioctl end) then
  ffi.cdef('int ioctl(int fd, unsigned long request, ...);')
end

-- gen goes up on each preview, zoom and close; a curl/ffmpeg result from an older gen is dropped.
-- While a preview is open, state also holds:
--   win, buf, saved_maps   float, buffer with the zoom keys, that buffer's own maps for those keys
--   src                    downloaded bytes, so zoom decodes again from the original
--   id                     Kitty image id on screen
--   cw, ch, max_w, max_h   cell size and editor box, in pixels
--   base_w, base_h, steps  first size and zoom steps from it; w, h is the current size
local state = { gen = 0 }

local function send(data)
  if vim.fn.chansend(vim.v.stderr, data) == 0 then
    error('url_image_preview: write to terminal (stderr) failed', 0)
  end
end

-- Pixel size of one terminal cell, from the same fd we draw on.
local function cell_size()
  local ws = ffi.new('unsigned short[4]') -- row, col, xpixel, ypixel
  if ffi.C.ioctl(2, TIOCGWINSZ, ws) ~= 0 then
    error('url_image_preview: stderr is not a terminal', 0)
  end
  if ws[2] == 0 or ws[3] == 0 then
    error('url_image_preview: terminal reports 0 pixel size (TIOCGWINSZ)', 0)
  end
  if ws[0] ~= vim.o.lines or ws[1] ~= vim.o.columns then
    error(('url_image_preview: stderr terminal is %dx%d but Nvim is %dx%d (remote UI?)')
      :format(ws[1], ws[0], vim.o.columns, vim.o.lines), 0)
  end
  return ws[2] / ws[1], ws[3] / ws[0]
end

local function count(s, char)
  return select(2, s:gsub('%' .. char, ''))
end

-- The match for pattern that covers column col of line, or nil.
local function find_at(line, col, pattern)
  local init = 1
  while true do
    local s, e = line:find(pattern, init)
    if not s then return nil end
    local text = line:sub(s, e):gsub('[.,;:!?]+$', '')
    -- Drop a closing bracket that belongs to the text, as in [x](https://a/b.png)
    for open, close in pairs({ ['('] = ')', ['['] = ']' }) do
      while text:sub(-1) == close and count(text, close) > count(text, open) do
        text = text:sub(1, -2)
      end
    end
    if col >= s and col < s + #text then return text end
    init = e + 1
  end
end

-- Same as Vim's g?: ASCII letters only.
local function rot13(s)
  return (s:gsub('[A-Za-z]', function(c)
    local base = c <= 'Z' and 65 or 97
    return string.char((c:byte() - base + 13) % 26 + base)
  end))
end

-- Returns the URL to fetch and the text as written in the buffer.
-- A URL encoded with g? (uggcf://...) is decoded.
local function url_under_cursor()
  local line, col = vim.api.nvim_get_current_line(), vim.fn.col('.')
  local text = find_at(line, col, 'https?://[^%s<>"\'`]+')
  if text then return text, text end
  text = find_at(line, col, 'uggcf?://[^%s<>"\'`]+')
  if text then return rot13(text), text end
  return nil
end

local function u32(s, i)
  local a, b, c, d = s:byte(i, i + 3)
  return ((a * 256 + b) * 256 + c) * 256 + d
end

local function echo(msg)
  vim.api.nvim_echo({ { msg } }, false, {})
end

local function transmit(png, id)
  local b64 = vim.base64.encode(png)
  for i = 1, #b64, CHUNK_SIZE do
    -- q=2: the TUI cannot read Kitty (APC) replies, and they would arrive as keystrokes.
    local keys = i == 1 and ('a=t,f=100,t=d,i=%d,q=2,'):format(id) or 'q=2,'
    local more = i + CHUNK_SIZE <= #b64 and 1 or 0
    send(('%s_G%sm=%d;%s%s\\'):format(ESC, keys, more, b64:sub(i, i + CHUNK_SIZE - 1), ESC))
  end
end

-- Save cursor, move to the cell, place, restore. One write, so the TUI's own
-- output cannot land between the move and the placement.
local function place(id, row, col, x_off, y_off)
  send(('%s7%s[%d;%dH%s_Ga=p,i=%d,X=%d,Y=%d,C=1,q=2%s\\%s8')
    :format(ESC, ESC, row, col, ESC, id, x_off, y_off, ESC, ESC))
end

local function delete(id)
  send(('%s_Ga=d,d=I,i=%d,q=2%s\\'):format(ESC, id, ESC))
end

-- First frame of src as a PNG that fits box_w x box_h, aspect ratio kept.
-- grow = false keeps an image that already fits at its own size.
local function decode(src, box_w, box_h, grow, gen, on_png)
  local scale = grow and ('scale=%d:%d'):format(box_w, box_h)
    or ("scale='min(iw,%d)':'min(ih,%d)'"):format(box_w, box_h)
  vim.system({
    'ffmpeg', '-hide_banner', '-loglevel', 'error', '-i', 'pipe:0', '-frames:v', '1',
    '-vf', scale .. ':force_original_aspect_ratio=decrease:flags=lanczos',
    '-pix_fmt', 'rgba', '-c:v', 'png', '-f', 'image2pipe', 'pipe:1',
  }, { stdin = src }, vim.schedule_wrap(function(conv)
    if gen ~= state.gen then return end
    if conv.code ~= 0 then
      error(('url_image_preview: ffmpeg exit %d: %s'):format(conv.code, conv.stderr), 0)
    end
    on_png(conv.stdout)
  end))
end

local zoom

local function open(config)
  local win = vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), false,
    vim.tbl_extend('error', config, { style = 'minimal', border = 'rounded', focusable = false }))
  state.win = win

  -- Zoom keys are buffer-local and exist only while the preview is open.
  -- Keep this buffer's own maps for those keys (fugitive and netrw have some) to put back.
  local buf = vim.api.nvim_get_current_buf()
  state.buf, state.saved_maps = buf, {}
  for lhs, dir in pairs(ZOOM_KEYS) do
    local old = vim.fn.maparg(lhs, 'n', false, true)
    if old.buffer == 1 then table.insert(state.saved_maps, old) end
    vim.keymap.set('n', lhs, function() zoom(dir) end,
      { buffer = buf, nowait = true, desc = 'Zoom image preview' })
  end

  local group = vim.api.nvim_create_augroup('UrlImagePreview', { clear = true })
  vim.api.nvim_create_autocmd(
    { 'CursorMoved', 'CursorMovedI', 'InsertEnter', 'BufLeave', 'WinLeave', 'VimResized', 'VimLeavePre' },
    -- nested: M.close() must trigger the WinClosed handler below
    { group = group, once = true, nested = true, callback = M.close })
  vim.api.nvim_create_autocmd('WinClosed', {
    group = group,
    pattern = tostring(win),
    once = true,
    callback = function()
      delete(state.id)
      if vim.api.nvim_buf_is_valid(buf) then
        for lhs in pairs(ZOOM_KEYS) do
          vim.keymap.del('n', lhs, { buffer = buf })
        end
        vim.api.nvim_buf_call(buf, function()
          for _, m in ipairs(state.saved_maps) do
            vim.fn.mapset('n', false, m)
          end
        end)
      end
      vim.api.nvim_clear_autocmds({ group = group })
      state = { gen = state.gen + 1 }
    end,
  })
end

-- Show png in the float (open it on the first call), then remove the image it replaces.
local function render(png)
  if png:sub(1, 8) ~= '\137PNG\r\n\26\n' then
    error('url_image_preview: ffmpeg output is not a PNG', 0)
  end
  local w, h = u32(png, 17), u32(png, 21)
  local cols, rows = math.ceil(w / state.cw), math.ceil(h / state.ch)
  local old_id = state.id
  state.id = old_id and old_id + 1 or FIRST_IMAGE_ID
  transmit(png, state.id)

  local config = {
    relative = 'editor',
    row = math.floor((vim.o.lines - vim.o.cmdheight - rows - 2) / 2),
    col = math.floor((vim.o.columns - cols - 2) / 2),
    width = cols,
    height = rows,
    title = (' %dx%d '):format(w, h),
    title_pos = 'center',
  }
  if state.win then
    vim.api.nvim_win_set_config(state.win, config)
  else
    open(config)
  end
  state.w, state.h = w, h
  echo('')
  vim.cmd.redraw()

  -- The image is drawn at its own pixel size (no c=/r=), so the aspect ratio is exact.
  -- X/Y centre it inside the float; the leftover is less than one cell.
  local pos = vim.fn.screenpos(state.win, 1, 1)
  if pos.row == 0 then
    error('url_image_preview: float is not on screen', 0)
  end
  place(state.id, pos.row, pos.col,
    math.floor((cols * state.cw - w) / 2), math.floor((rows * state.ch - h) / 2))
  -- Delete the old image after the new one is placed, so the float never shows empty.
  if old_id then delete(old_id) end
end

-- dir = 1 zooms in, -1 zooms out. Each step is x1.1 or /1.1, so + then - gives the same size.
zoom = function(dir)
  local f = ZOOM_STEP ^ state.steps
  if dir > 0 and (state.base_w * f >= state.max_w - 1 or state.base_h * f >= state.max_h - 1) then
    echo('Image preview is at maximum size')
    return
  end
  f = ZOOM_STEP ^ (state.steps + dir)
  local tw, th = state.base_w * f, state.base_h * f
  if dir < 0 and (tw < state.cw or th < state.ch) then
    echo('Image preview is at minimum size')
    return
  end
  state.steps = state.steps + dir
  state.gen = state.gen + 1
  decode(state.src, math.floor(math.min(tw, state.max_w)), math.floor(math.min(th, state.max_h)),
    true, state.gen, render)
end

function M.close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
end

-- width, height: size when the preview opens, as part of the editor (0 < n <= 1).
-- Small images open at their own size. Zoom can then go up to the full editor.
local defaults = { width = 1, height = 1 }

function M.preview(opts)
  opts = opts or {}
  for k, v in pairs(opts) do
    if defaults[k] == nil then
      error('url_image_preview: unknown option ' .. k, 0)
    end
    if not (type(v) == 'number' and v > 0 and v <= 1) then
      error(('url_image_preview: %s must be a number in (0, 1], got %s'):format(k, vim.inspect(v)), 0)
    end
  end
  opts = vim.tbl_extend('force', defaults, opts)

  M.close()
  if vim.env.TMUX then
    error('url_image_preview: tmux is not supported (needs graphics passthrough)', 0)
  end
  local url, text = url_under_cursor()
  if not url then
    error('url_image_preview: no http(s) URL under cursor (plain or g? encoded)', 0)
  end
  local cw, ch = cell_size()
  -- Editor box less the border and a 1-cell margin.
  local max_w = math.floor((vim.o.columns - 4) * cw)
  local max_h = math.floor((vim.o.lines - vim.o.cmdheight - 4) * ch)

  state.gen = state.gen + 1
  local gen, win, cursor = state.gen, vim.api.nvim_get_current_win(), vim.api.nvim_win_get_cursor(0)
  -- Show the text as written, so a g? encoded URL is not shown decoded.
  echo('Fetching ' .. text)

  vim.system({ 'curl', '-q', '-fsSL', '--max-time', '20', '--proto', '=http,https', url }, {},
    vim.schedule_wrap(function(dl)
      if gen ~= state.gen then return end
      if dl.code ~= 0 then
        error(('url_image_preview: curl exit %d: %s'):format(dl.code, dl.stderr), 0)
      end
      decode(dl.stdout, math.floor(max_w * opts.width), math.floor(max_h * opts.height), false, gen,
        function(png)
          if vim.api.nvim_get_current_win() ~= win
            or not vim.deep_equal(vim.api.nvim_win_get_cursor(0), cursor) then
            echo('Image preview cancelled: cursor moved')
            return
          end
          state.src, state.cw, state.ch, state.max_w, state.max_h, state.steps =
            dl.stdout, cw, ch, max_w, max_h, 0
          render(png)
          state.base_w, state.base_h = state.w, state.h
        end)
    end))
end

return M
