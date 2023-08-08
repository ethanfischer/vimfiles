"start maximized
"au GUIEnter * simalt ~x

"tutorial followed for gvim setup https://www.youtube.com/watch?v=FuPFoVDdTtE&t=1458s
"source $HOME/vimfiles/vimrc

"FONT
"if has("gui_running")
"  if has("gui_gtk2")
"    set guifont=Inconsolata\ 12
"  elseif has("gui_macvim")
"    set guifont=Menlo\ Regular:h14
"  elseif has("gui_win32")
"    set guifont=Consolas:h11:cANSI
"  endif
"endif

""VIM PLUG setup https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/vimfiles/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Plugins recommended by ThePrimeagen:https://www.youtube.com/watch?v=n9k9scbTuvQ&t=735s
" Color Scheme
Plug 'morhetz/gruvbox'
Plug 'srcery-colors/srcery-vim'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-commentary'
Plug 'andrewradev/sideways.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bling/vim-airline'
Plug 'pedrohdz/vim-yaml-folds'
"Plug 'sagarrakshe/toggle-bool'
Plug 'ThePrimeagen/vim-be-good'
Plug 'dense-analysis/ale'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'jkramer/vim-checkbox'
Plug 'machakann/vim-highlightedyank'
Plug 'jbyuki/quickmath.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" Initialize plugin system
call plug#end()

colorscheme gruvbox

set background=dark

set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=e "remove tab pages
set guioptions-=r "remove right scrollbar
set guioptions-=R "remove right scrollbar
set guioptions-=l "remove left scrollbar
set guioptions-=L "remove left scrollbar

"nvim specific keybindings:
nnoremap <leader>sp :edit!~/Documents/Notes/ScratchPad.txt<CR>
nnoremap <leader>smxg :NERDTree ~/repos/ics/InContext.SMXGo<CR>    
"nnoremap <leader>ics :NERDTree C:\Users\ethan.fischer\GitProjects\ICS<CR>    

" specific keybindings
nnoremap <silent><leader>nt :NERDTreeFind<CR>
nnoremap <silent><leader> :WhichKey '<Space>'<CR>
"nnoremap <c-l> :SidewaysRight<CR>
"nnoremap <c-h> :SidewaysLeft<CR>
"nmap gd <Plug>(coc-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"toggle bool
"noremap <c-a> :ToggleBool<CR>

"checkbox
"default is leader tt
nnoremap <leader><enter> :ToggleCB<CR>


set statusline^=%{coc#status()}
let g:airline_section_z = ''
let g:airline_section_y = ''
let g:airline_section_warning=""


"Autocomplete mappings inspired by this link but slightly tweaked to my liking
"https://github.com/hrsh7th/nvim-compe/issues/141
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n><C-y>" : "\<TAB>" 
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <enter> pumvisible() ? "\<C-y>" : "\<Enter>"


"let g:lf_replace_netrw = 1 " Open lf when vim opens a directory

"execute current file from shell (make sure to :cd %/.. first)
"nnoremap <F5> :!%<CR>
nnoremap <F5> :!cargo run<CR>

" set highlight to whatever amount of ms
let g:highlightedyank_highlight_duration = 500

lua << EOF
vim.lsp.set_log_level("debug")

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- Keybindings for LSP actions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<F12>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<c-k><c-i>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-F12>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('i', '<C-S-Space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = {
  rust_analyzer = {}
}

for server, config in pairs(servers) do
  config.on_attach = on_attach
  nvim_lsp[server].setup(config)
end

local cmp = require'cmp'
cmp.setup {
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'nvim_lsp' }
  },
}
EOF
