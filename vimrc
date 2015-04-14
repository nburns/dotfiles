set shell=bash
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" user bundles
Plugin 'altercation/vim-colors-solarized'
Plugin 'Raimondi/delimitMate'
Plugin 'bling/vim-airline'
Plugin 'xolox/vim-misc'
Plugin 'guns/vim-clojure-static'
Plugin 'lh-vim-lib'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/applescript.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'dag/vim-fish'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable

let mapleader=","
let g:netrw_dirhistmax=0 " disable netrw

let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1 " use powerline fonts
"let g:syntastic_python_pylint_args='--rcfile=/Users/nick/.pylintrc'

au FileType python let b:delimitMate_nesting_quotes = ['"']

set spellfile="/Users/nick/Documents/dictionaries/dictionary.dic"

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
set t_Co=256
if has("gui_running")
    let g:solarized_contrast="high"
    set background=dark
    colorscheme solarized
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    let g:solarized_contrast="high"
    set background=dark
    colorscheme solarized
endif

set autoindent smartindent
set autoread " update externaly edited files
set backspace=eol,start,indent " fix backspace
set clipboard=unnamed "use system clipboard
set cmdheight=1
set colorcolumn=81
set cursorline
set encoding=utf8 " use utf8 text encoding
set expandtab " convert tabs to spaces
set ffs=unix,dos,mac " use unix file format
set hlsearch
set incsearch
set laststatus=2
set linespace=2
set magic
set mouse=a
set nobackup " disable local backup
set noerrorbells
set nofoldenable
set noswapfile " disable local backup
set novisualbell
set nowb " disable local backup
set nowrap
set number
set ruler
set shiftwidth=4
set showmatch
set smarttab " use smarttabs
set t_vb=
set tabstop=4
set tags=tags;/
set timeout timeoutlen=1500
set tm=500
set ttymouse=xterm2
set whichwrap+=<,>,h,l " fix backspace


" map command to meta
if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif


inoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" kill word backwards
inoremap <C-BS> <C-\><C-o>db

" copy the whole file
noremap <Leader>c :!cat %\|pbcopy<CR>

" w!! to write as sudo
cmap w!! w !sudo tee > /dev/null %


" delete extra whitespace
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

map <leader>ss :setlocal spell!<cr>


" relative line numbers for active buffer
:au FocusLost * :set number
:au FocusGained * :set relativenumber

" remember last open position of a buffer
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%

" clear highliting with space
map <Space> :noh<cr>
