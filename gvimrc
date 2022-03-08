"start maximized
au GUIEnter * simalt ~x

"tutorial followed for gvim setup https://www.youtube.com/watch?v=FuPFoVDdTtE&t=1458s
"source $HOME/vimfiles/vimrc

"FONT
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

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
Plug 'sagarrakshe/toggle-bool'
Plug 'ThePrimeagen/vim-be-good'
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'jkramer/vim-checkbox'
Plug 'chaoren/vim-wordmotion'
Plug 'antoinemadec/FixCursorHold.nvim'
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

"gVim specific keybindings:
nnoremap <leader>sp :edit!$HOME/Documents/Notes/ScratchPad.txt<CR>
"nnoremap <leader>ics :NERDTree C:/InContext/Git/<CR>    
nnoremap <leader>ics :NERDTree C:\Users\ethan.fischer\GitProjects\ICS<CR>    

" specific keybindings
nnoremap <silent><leader>nt :NERDTreeFind<CR>
nnoremap <silent><leader> :WhichKey '<Space>'<CR>
nnoremap <c-l> :SidewaysRight<CR>
nnoremap <c-h> :SidewaysLeft<CR>
nmap gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"toggle bool
noremap <c-a> :ToggleBool<CR>

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

let g:lf_replace_netrw = 1 " Open lf when vim opens a directory

"execute current file from shell (make sure to :cd %/.. first)
nnoremap <F5> :!%<CR>

"For jumping to next capital letter or underscore casing, use leader-w,
"leader-b, etc
let g:wordmotion_prefix = '<Leader>'

"nnoremap <F12> :OmniSharpGotoDefinition<CR>
"nnoremap <S-F12> :OmniSharpFindUsages<CR>
"nnoremap <C-F12> :OmniSharpFindImplementations<CR>


"OmniSharp Settings
"
" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

let g:ale_hover_to_floating_preview = 1
let g:ale_floating_preview = 1

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  " Ethan: commenting out for now since we want to see error details
  "autocmd CursorHold *.cs OmniSharpTypeLookup 

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> <F12> <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <S-F12> <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <C-F12> <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <C-.> <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <C-.> <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <F2> <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

let g:OmniSharp_selector_findusages = 'fzf'

" Enable snippet completion, using the ultisnips plugin
" let g:OmniSharp_want_snippet=1

"End of Omnisharp Settings

" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 500

