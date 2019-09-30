if has('python3')
  silent! python3 1
endif

set shell=bash
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/bin/fzf
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" user bundles
" color scheme
Plugin 'altercation/vim-colors-solarized'

" editor enhancements
Plugin 'Raimondi/delimitMate' "delimiter autocompletion
Plugin 'tpope/vim-endwise' "ruby end tags
Plugin 'vim-scripts/ruby-matchit' " % jumps in ruby code
Plugin 'vim-scripts/BufClose.vim' " :BufClose closes current buffer
Plugin 'SirVer/ultisnips' " UltiSnips
Plugin 'honza/vim-snippets' " snippets
Plugin 'airblade/vim-gitgutter' " git
Plugin 'tpope/vim-rsi' "readline bindings
Plugin 'itchyny/lightline.vim'
Plugin 'godlygeek/tabular'

" language plugins
Plugin 'dag/vim-fish'
"Plugin 'vim-scripts/applescript.vim'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'
Plugin 'ianks/vim-tsx'
Plugin 'lepture/vim-velocity'
"Plugin 'hashivim/vim-terraform'
"Plugin 'mustache/vim-mustache-handlebars'
"Plugin 'Glench/Vim-Jinja2-Syntax'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable

let mapleader=","
let g:netrw_dirhistmax=0 " disable netrw

let g:ctrlp_working_path_mode = 'r'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:terraform_fmt_on_save=1
let g:terraform_align=1

" set the diff branch for the gutter
" call with no args to set to master
function! Diff(...)
    call gitgutter#all(a:1)
endfunction
let g:gitgutter_eager=1
command! -nargs=? Diff call Diff(<f-args>)

au FileType python let b:delimitMate_nesting_quotes = ['"']
let delimitMate_expand_cr = 1

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.applescript set filetype=applescript

" force jsx highlighting for javascript files
let g:jsx_ext_required = 0

set guifont=DejaVu\ Sans\ Mono:h15

set t_Co=256
if (has("termguicolors"))
 set termguicolors
endif

let g:lightline = { 'colorscheme': 'solarized' }
let g:solarized_contrast="high"
colorscheme solarized

let hour = (strftime('%H'))
let night = hour > 17
if night || 1
    set background=dark
else
    set background=light
endif


if has("gui_running")
    set lines=70
    set columns=88
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
set modeline
set modelines=5
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
set showcmd " show command info at bottom of editor
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
set linebreak


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

" delete trailing whitespace
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

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

autocmd FileType haml,ruby,javascript,yaml,typescript,scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType text,markdown setlocal linebreak wrap


" format on save
autocmd BufWritePost *.js,*.ts,*.tsx,*.jsx silent! !prettier --write <afile>
autocmd BufWritePost *.rb,*.rake silent! !rubocop <afile> --auto-correct

autocmd FileType python
    \ autocmd BufWritePost * silent! !autopep8 --in-place --aggressive --aggressive <afile>


" format xml on save
"autocmd BufWritePost *.xml silent! %!xmllint --format --recover <afile>
