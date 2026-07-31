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

"set colorcolumn=80
"highlight ColorColumn ctermbg=0 

"set clipboard=unnamed Disabling temporarily so I can figure out if clipboard
"is causing lags in Visual Studio
"https://github.com/VsVim/VsVim/issues/2035
set clipboard=unnamed
set nornu
set number
"set shell=$COMSPEC "

"space leader
let mapleader = " "

nnoremap <c-q> <c-v>
"nnoremap <c-r>  viw"0P

"Scroll down
nnoremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>M
"Scroll up
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>M

"Put on line below
"nnoremap <c-j> :pu<CR>
"nnoremap <c-k> :pu!<CR>

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
nnoremap <C-_> <C-o>
"nnoremap <Shift C-_> <C-i> no way to map to ctrl shift minus in Vim :(

nnoremap <leader>wq :wq<CR>
nnoremap <c-p> :FZF<CR>
nnoremap <c-f> :Rg<Space>
nnoremap <leader>9 :tabprev<CR>
nnoremap <leader>0 :tabnext<CR>
nnoremap <leader>dd :%d<CR> "delete all lines in file
nnoremap <leader>yy :%y<CR>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"format json
nnoremap <leader>fj :%!jq .<CR>
"remove escape characters and starting and ending quotes from copied json
nnoremap <leader>/j V:s/\\//g0x$x<CR>
"remove windows carraige returns
noremap <leader>/m :%s/\r//g<CR>


"Copy open file path
noremap <F1> :let @+=expand("%:p")<CR>

noremap <leader>; :set rnu!<CR>
noremap <leader># :set rnu!<CR>


"capital y should yank to end of line, just like capital c and capital d
"operates to the end of the line
nnoremap Y y$
nnoremap V v$
vnoremap v V

"don't jump when yanking
"vnoremap y y']


" CTRL-C and are Copy to windows clipboard
vnoremap <C-C> "+y

"make certain characters undoable in insert mode
"inoremap , ,<c-g>u
"inoremap . .<c-g>u
"inoremap [ [<c-g>u
"inoremap ! !<c-g>u
"inoremap ? ?<c-g>u

"ability to move highlighted lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"open
"nnoremap <C-o> :open<CR>

"recent files
nnoremap <leader>? :browse oldfiles<CR>

"Remove empty lines
"g/^$/d

"Reload vimrc on save
"autocmd! bufwritepost .vimrc source %

"good to know:
    "nnoremap stands for normal-no-recursive-map
    "nvim's version of vimrc is at ~/.config/nvim/init.vim
    "browse oldfiles brings up recently edited files

"vim diff command
":vert diffs otherfile.config

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

nnoremap <C-B> :!cargo run<CR>

" Disable virtual text diagnostics (LSP inline warnings) - Neovim only
if has('nvim')
    autocmd LspAttach * lua vim.diagnostic.config({ virtual_text = false })
    " Toggle diagnostic virtual text
    nnoremap <leader>dt :lua vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })<CR>
endif

" Disable CoC virtual text
let g:coc_disable_transparent_cursor = 1
let g:coc_enable_locationlist = 0

" Function to swap the first two parameters of a function call
function! SwapFunctionParams()
    let line = getline('.')
    let col = col('.')
    
    " Find the function call pattern: function_name(param1, param2, ...)
    let pattern = '\(\w\+\s*(\)\([^,()]*\),\s*\([^,()]*\)\(.*)\)'
    
    " Try to match the pattern on the current line
    if match(line, pattern) != -1
        let new_line = substitute(line, pattern, '\1\3, \2\4', '')
        call setline('.', new_line)
        echo "Parameters swapped"
    else
        echo "No function call with parameters found on this line"
    endif
endfunction

" Map to <leader>, (swap parameters)
nnoremap <leader>, :call SwapFunctionParams()<CR>

let g:private_mode = 0
function! TogglePrivateMode()
if g:private_mode
  hi Normal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  let g:private_mode = 0
  echo "Private mode OFF"
else
  hi Normal ctermfg=black ctermbg=black guifg=black guibg=black
  let g:private_mode = 1
  echo ""
endif
endfunction
nnoremap <Leader>p :call TogglePrivateMode()<CR>
