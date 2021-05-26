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


set statusline^=%{coc#status()}
let g:airline_section_z = ''
let g:airline_section_y = ''
let g:airline_section_warning=""
