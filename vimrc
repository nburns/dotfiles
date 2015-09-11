set shell=bash
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" user bundles
" color scheme
Plugin 'altercation/vim-colors-solarized'

" editor enhancements
Plugin 'Raimondi/delimitMate' "delimiter autocompletion
Plugin 'scrooloose/nerdcommenter' "commenting
Plugin 'vim-scripts/BufClose.vim' " :BufClose closes current buffer
Plugin 'mileszs/ack.vim' 
Plugin 'SirVer/ultisnips' " UltiSnips
Plugin 'honza/vim-snippets' " snippets
"Plugin 'wookiehangover/jshint.vim'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter' " git


Plugin 'tpope/vim-rsi' "readline bindings

Plugin 'bling/vim-airline' " statusline
"Plugin 'xolox/vim-misc'
"Plugin 'vim-scripts/lh-vim-lib'

" language plugins
Plugin 'dag/vim-fish'
Plugin 'kchmck/vim-coffee-script'
Plugin 'fatih/vim-go'
Plugin 'undx/vim-gocode'
Plugin 'vim-scripts/applescript.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'sukima/xmledit'
Plugin 'gregsexton/MatchTag'
Plugin 'kien/ctrlp.vim' " fuzzy search

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
let g:ctrlp_working_path_mode = 'r'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


function! Diff(...)
    if a:0 == 1
        let g:gitgutter_diff_args=a:1
    else
        let g:gitgutter_diff_args=""
    endif
    call gitgutter#all()
endfunction
let g:gitgutter_eager=1
command! -nargs=? Diff call Diff(<f-args>)

au FileType python let b:delimitMate_nesting_quotes = ['"']
let delimitMate_expand_cr = 1

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let host=system('hostname -s')
if host == 'bernoulli'
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13
else
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
endif

set t_Co=256
if has("gui_running")
    let g:solarized_contrast="high"
    set background=dark
    colorscheme solarized
    set lines=60
    set columns=100
else
    " iterm2 escape codes
    if &term =~ 'screen'
        " in tmux/screen escape the escapes
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    end
    let g:solarized_contrast="high"
    set background=dark
    colorscheme solarized
endif

if filereadable("~/.words.utf-8.add")
    set spellfile="~/.words.utf-8.add"
endif

set autoindent smartindent
set autoread " update externaly edited files
set backspace=eol,start,indent " fix backspace
set clipboard=unnamed "use system clipboard
set cmdheight=1
set colorcolumn=81
set cursorline " Highlight the screen line of the cursor
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
set nowrap "dont wrap lines
set number " show line numbers
set ruler
set scrolloff=10 " amount of context around the cursor
set shiftwidth=4 " autoindent columns
set showmatch
set smarttab " use smarttabs
set vb t_vb= " no bell
set tabstop=4 " tabs are 4 spaces
set tags=tags;/ " tagsfile name
set timeout timeoutlen=1500
set tm=500
set ttymouse=xterm2
set whichwrap+=<,>,h,l " fix backspace
set fileformat=unix
set splitbelow " open new splits below
set splitright " open new splits to the right


" map command to meta
if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" allows command s saving in terminal
" first remap command + s to send hex code 0x13
noremap <C-S> :w<CR>
vnoremap <C-S> <C-C>:w<CR>
inoremap <C-S> <C-O>:w<CR>

" subset of emacs style movement commands
inoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" kill word backwards 
inoremap <C-BS> <C-\><C-o>db 

" change buffer with tab in normal mode
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" disable arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" change buffers with fewer keystrokes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" copy the whole file
noremap <Leader>c :!cat %\|pbcopy<CR>

" w!! to write as sudo
cmap w!! w !sudo tee > /dev/null %

"avoids the annoying 'Not an editor command: W'
cabbrev WQ wq
cabbrev Wq wq
cabbrev W w
cabbrev Q q
cabbrev Q! q!


" delete extra whitespace
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

map <leader>ss :setlocal spell!<cr>

map <leader>c :BufClose<cr>

" remember last open position of a buffer
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%

" clear highliting with space
map <Space> :noh<cr>

