set shell=bash
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" user bundles
" color scheme
Plugin 'altercation/vim-colors-solarized'

" editor enhancements
Plugin 'Raimondi/delimitMate' "delimiter autocompletion
Plugin 'scrooloose/nerdcommenter' "commenting
Plugin 'vim-scripts/BufClose.vim' " :BufClose closes current buffer
Plugin 'SirVer/ultisnips' " UltiSnips
Plugin 'honza/vim-snippets' " snippets
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter' " git
Plugin 'tpope/vim-rsi' "readline bindings
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'godlygeek/tabular'

" language plugins
Plugin 'dag/vim-fish'
"Plugin 'vim-scripts/applescript.vim'
"Plugin 'sukima/xmledit'
Plugin 'tpope/vim-endwise' "ruby end tags
Plugin 'tpope/vim-haml'
Plugin 'vim-scripts/ruby-matchit'
"Plugin 'jvirtanen/vim-octave'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
"Plugin 'keith/swift.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'ianks/vim-tsx'
Plugin 'bkad/vim-terraform'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable

let mapleader=","
let g:netrw_dirhistmax=0 " disable netrw

let g:airline_theme="solarized"
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

let g:ctrlp_working_path_mode = 'r'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"let g:typescript_indent_disable = 1

" set the diff branch for the gutter
" call with no args to set to master
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

let g:go_fmt_command = "goimports"

au FileType python let b:delimitMate_nesting_quotes = ['"']
let delimitMate_expand_cr = 1

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.applescript set filetype=applescript

" force jsx highlighting for javascript files
let g:jsx_ext_required = 0

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13

set t_Co=256
let g:solarized_contrast="high"
colorscheme solarized

let hour = (strftime('%H'))
if hour > 17
    set background=dark
else
    set background=light
endif

if has("gui_running")
    set lines=70
    set columns=88
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
endif

set autoindent smartindent
set autoread " update externaly edited files
set backspace=eol,start,indent " fix backspace
set clipboard=unnamed "use system clipboard
set cmdheight=1
set colorcolumn=81
set cursorline " Highlight the horizontal line of the cursor
set cursorcolumn " Highlight vertical column of the cursor
set encoding=utf8 " use utf8 text encoding
set expandtab " convert tabs to spaces
set ffs=unix,dos,mac " use unix file format
set fileformat=unix
set hidden "hide buffers instead of closing
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
set spell
set splitbelow " open new splits below
set splitright " open new splits to the right
set tabstop=4 " tabs are 4 spaces
set tags=tags;/ " tagsfile name
set timeout timeoutlen=1500
set tm=500
set ttymouse=xterm2
set vb t_vb= " no bell
set whichwrap+=<,>,h,l " fix backspace


" map command to meta
if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" subset of emacs style movement commands
inoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" kill word backwards 
inoremap <C-BS> <C-\><C-o>db 

" change buffer with tab in normal mode
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" copy the whole file
noremap <Leader>c :!cat %\|pbcopy<CR>

" w!! to write as sudo
cmap w!! w !sudo tee > /dev/null %

"avoids the annoying 'Not an editor command: W'
cabbrev WQ wq
cabbrev Wq wq
cabbrev wQ wq
cabbrev W w
cabbrev Q q
cabbrev Q! q!

nnoremap <Leader>q :BufClose


"" delete strip trailing extra whitespace
"func! DeleteTrailingWS()
"  exe "normal mz"
"  %s/\s\+$//ge
"  exe "normal `z"
"endfunc
"autocmd BufWrite *.py :call DeleteTrailingWS()

autocmd FileType ruby,haml,javascript,scss,yaml,python,typescript,typescript.tsx autocmd BufWritePre <buffer> :%s/\s\+$//e

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

" statusline
" column number
"set statusline=\ \ %c
" end left alignment, begin right alignment
"set statusline+=%=
" modified flag, file path, limited to 40 chars
"set statusline+=\ %m\ %.40F
"set statusline+=\ 
" file type
"set statusline+=%y

autocmd FileType haml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
