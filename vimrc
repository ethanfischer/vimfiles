syntax on
set nocompatible
set backspace=indent,eol,start
set noerrorbells
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undofile
set undodir=~/vimfiles/undodir
set incsearch
set foldmethod=syntax
set foldlevelstart=99 "open all folds

"set colorcolumn=80
"highlight ColorColumn ctermbg=0 

set clipboard=unnamed
set nornu
set number
set shell=$COMSPEC "

"space leader
let mapleader = " "

nnoremap <c-q> <c-v>
"nnoremap <c-r>  viw"0P

"Scroll down
nnoremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>     
"Scroll up
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

"Put on line below
nnoremap <c-j> :pu<CR>
nnoremap <c-k> :pu!<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif


" Quickly open/reload vimrc
nnoremap <leader>rc :tabe $HOME/vimfiles/vimrc<CR>  
nnoremap <leader>grc :tabe $HOME/vimfiles/gvimrc<CR>  
nnoremap <leader>so :source $HOME/vimfiles/vimrc<CR>
nnoremap <leader>gso :source $HOME/vimfiles/gvimrc<CR>

nnoremap <leader>q :q<CR>
nnoremap <c-s> :w<CR>
nnoremap <c-t> :tabe<CR>

nnoremap <leader>wq :wq<CR>
nnoremap <c-p> :FZF<CR>
nnoremap <c-f> :Rg<Space>
nnoremap <leader>9 :tabprev<CR>
nnoremap <leader>0 :tabnext<CR>
nnoremap <leader>dd :%d<CR> "delete all lines in file
nnoremap <leader>vv ggVG<CR> "highlight all lines in file

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"format json
nnoremap <leader>fj :%!python -m json.tool<CR> :set syntax=json<CR>

"Copy open file path
noremap <F1> :let @+=expand("%:p")<CR>

noremap <leader># :set rnu!<CR>

"Reload vimrc on save
"autocmd! bufwritepost .vimrc source %

"good to know:
    "nnoremap stands for normal-no-recursive-map

"G is from Git-fugitive 
command StashAll G add . | G stash
command Sta StashAll
command StashPop G stash pop
command Stp StashPop
command Nuke G reset --hard | G clean -fd
command Chm G checkout master
command CheckoutPrevious G checkout -
command Chp CheckoutPrevious
command MergeMaster G checkout master | G pull | G checkout - | G merge master
command Mm MergeMaster
