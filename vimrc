syntax on
set nocompatible
set backspace=indent,eol,start
set noerrorbells
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
"set nowrap
set wrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undofile
set undodir=~/vimfiles/undodir
set incsearch
set foldmethod=syntax
set foldlevelstart=99 "open all folds
set encoding=utf8
set guioptions-=a
set diffopt=vertical
""set autoread

"set colorcolumn=80
"highlight ColorColumn ctermbg=0 

"set clipboard=unnamed Disabling temporarily so I can figure out if clipboard
"is causing lags in Visual Studio
"https://github.com/VsVim/VsVim/issues/2035
set clipboard=unnamed
set rnu
set shell=$COMSPEC "

"not entirely sure what this does but it's supposed to fix issue with
"omnisharp where intellisense gets out of date
"https://github.com/OmniSharp/omnisharp-vim/issues/660
"set hidden


"space leader
let mapleader = " "

nnoremap <c-q> <c-v>
"nnoremap <c-r>  viw"0P

"Scroll down
nnoremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>M
"Scroll up
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>M

"Put on line below
nnoremap <c-j> :pu<CR>
nnoremap <c-k> :pu!<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif


" Quickly open/reload vimrc
nnoremap <leader>rc :tabe $HOME/vimfiles/vimrc<CR>  
nnoremap <leader>grc :tabe $HOME/vimfiles/gvimrc<CR>  
nnoremap <leader>nrc :tabe $HOME/appdata/local/nvim/init.vim<CR>  
nnoremap <leader>so :source $HOME/vimfiles/vimrc<CR>
nnoremap <leader>gso :source $HOME/vimfiles/gvimrc<CR>

nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <c-s> :w<CR>
nnoremap <c-t> :tabe<CR>
"VStudio forward and back mappings
nnoremap <C--> <C-o>  
nnoremap <C-S-_> <C-i>

nnoremap <c-p> :FZF<CR>
nnoremap <c-f> :Rg<Space>
nnoremap <leader>9 :tabprev<CR>
nnoremap <leader>0 :tabnext<CR>
nnoremap <leader>dd :%d<CR> "delete all lines in file
nnoremap <leader>vv ggVG "highlight all lines in file

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"format json
nnoremap <leader>fj :%!python -m json.tool<CR> :set syntax=json<CR>
"remove escape characters and starting and ending quotes from copied json
nnoremap <leader>/j V:s/\\//g0x$x<CR>
nnoremap <leader>/jrn V:s/\\r\\n//g0x$x<CR>
"toggle blackslash/forwardslash in selection
vnoremap <leader>// :s,\\,/,g<CR>
vnoremap <leader>\\ :s,/,\\,g<CR>


"Copy open file path
noremap <F1> :let @+=expand("%:p")<CR>

noremap <leader>; :set rnu!<CR>
noremap <leader># :set rnu!<CR>


"capital y should yank to end of line, just like capital c and capital d
"operates to the end of the line
nnoremap Y y$
nnoremap V v$
vnoremap v V

" CTRL-C and are Copy to windows clipboard
vnoremap <C-C> "+y

"make certain characters undoable in insert mode
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap [ [<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

"ability to move highlighted lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"open (what? 2022/08/03)
"nnoremap <C-o> :open<CR>

"recent files
nnoremap <leader>? :browse oldfiles<CR>

"Remove empty lines
"g/^$/d

"Reload vimrc on save
"autocmd! bufwritepost .vimrc source %


"Auto insert matching brace, quote, etc
"inoremap { {<CR>}<Esc>O
"inoremap ( ()<Esc>ha
"inoremap [ []<Esc>ha
"inoremap " ""<Esc>ha
"inoremap ' ''<Esc>ha
"inoremap ` ``<Esc>ha

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


"good to know:
    "nnoremap stands for normal-no-recursive-map

    "vim diff command
        ":vert diffs otherfile.config
    "make numbered list from 1 to 10
        "put =range(1,10)
    "multi cursor editing
    " Ctrl V, Shift I to insert on multiple lines

    "gcc to toggle comments
    
    "to compare two files, create a vsplit (ctrl-w, v)(or :vsplit)
    "open the other file in the other split (ctrl-p, find file)
    "in one of the splits, enter :windo diffthis
    "https://old.reddit.com/r/vim/comments/hjblbb/vimdiff_builtin_tool_to_compare_two_or_more_files/
