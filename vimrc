"set shell=bash
"let $PATH .= ':/usr/local/bin'
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/bin/fzf
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" color scheme
Plugin 'lifepillar/vim-solarized8'
Plugin 'nburns/bbedit-vim-colors'
Plugin 'nburns/vim-auto-light-dark'

" editor enhancements
" Plugin 'Raimondi/delimitMate' "delimiter autocompletion
"Plugin 'tpope/vim-endwise' "ruby end tags
"Plugin 'vim-scripts/ruby-matchit' " % jumps in ruby code
"Plugin 'vim-scripts/BufClose.vim' " :BufClose closes current buffer
Plugin 'tyru/open-browser.vim' " req for open-browser-github
Plugin 'tyru/open-browser-github.vim' " open files on github
Plugin 'SirVer/ultisnips' " UltiSnips
Plugin 'honza/vim-snippets'
Plugin 'airblade/vim-gitgutter' " git
Plugin 'tpope/vim-rsi' "readline bindings
Plugin 'itchyny/lightline.vim'
"Plugin 'godlygeek/tabular'
Plugin 'ap/vim-css-color'
Plugin 'editorconfig/editorconfig-vim'

" language plugins
Plugin 'dag/vim-fish'
Plugin 'stevearc/vim-arduino'
"Plugin 'elixir-editors/vim-elixir'
"Plugin 'vim-scripts/applescript.vim'
"Plugin 'tpope/vim-haml'
Plugin 'lepture/vim-jinja'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
"Plugin 'leafgarland/typescript-vim'
"Plugin 'ianks/vim-tsx'
"Plugin 'fatih/vim-go'
"Plugin 'hashivim/vim-terraform'
Plugin 'bfrg/vim-cpp-modern'
"Plugin 'vim-crystal/vim-crystal'
"Plugin 'sirtaj/vim-openscad'

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
let g:terraform_align=0

"let g:go_fmt_command = "goimports"

" set the diff branch for the gutter
" call with no args to set to master
function! Diff(...)
    call gitgutter#all(a:1)
endfunction
let g:gitgutter_eager=1
command! -nargs=? Diff call Diff(<f-args>)

au FileType python let b:delimitMate_nesting_quotes = ['"\''']
let delimitMate_expand_cr = 1

" force jsx highlighting for javascript files
let g:jsx_ext_required = 0

if has("gui_running")
    if has("mac") || has("macunix")
        set guifont=DejaVu\ Sans\ Mono:h15
    else
        set guifont=DejaVu\ Sans\ Mono\ 10
    end
end

" make tmux have colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set termguicolors



set autoindent smartindent
set autoread " update externaly edited files
set backspace=eol,start,indent " fix backspace
set clipboard=unnamed "use system clipboard
set cmdheight=1
set colorcolumn=81
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
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
set modelines=2
set nobackup " disable local backup
set noerrorbells
set nofoldenable
set noswapfile nowb " disable local backup
set novisualbell
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


function DarkMode()
    colorscheme solarized8_high
    set background=dark
    let g:lightline = { 'colorscheme': 'solarized' }
endfunction

function LightMode()
    colorscheme bbedit
    set background=light
    let g:lightline = { 'colorscheme': 'PaperColor' }
endfunction


" map command to meta
if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" subset of emacs style movement commands
cnoremap <C-a> <Home>
inoremap <C-a> <Home>
nnoremap <C-a> <Home>

cnoremap <C-e> <End>
inoremap <C-e> <End>
nnoremap <C-e> <End>

" kill word backwards
inoremap <C-BS> <C-\><C-o>db

" kill to end of line
inoremap <C-k> <C-o>C
cnoremap <C-k> <C-o>C
nnoremap <C-k> C


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

autocmd FileType haml,ruby,javascript,yaml,typescript.tsx,typescript,scss,c,arduino setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript.tsx setlocal nospell

autocmd FileType text,markdown setlocal linebreak wrap

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.mdx set filetype=markdown
autocmd BufNewFile,BufReadPost *.applescript set filetype=applescript
autocmd BufNewFile,BufReadPost *.har set filetype=json


" format on save
autocmd BufWritePost *.c,*.ino silent! !clang-format -i <afile>
autocmd BufWritePost *.js,*.ts,*.tsx,*.jsx silent! !prettier --write <afile>
"autocmd FileType ruby autocmd BufWritePost * silent! !rubocop <afile> --auto-correct
"autocmd FileType python autocmd BufWritePost * silent! !autopep8 --aggressive --aggressive --in-place <afile>
"autocmd FileType python autocmd BufWritePost * silent! !black <afile>
autocmd BufWritePost *.ex,*.exs silent! !mix format <afile>
"autocmd BufWritePost *.sql silent! %!pg_format <afile> | sed \$d
"autocmd BufWritePost *.sql silent! !prettier --write <afile>; sed -i '' -e '$a\' <afile>
autocmd FileType xml autocmd BufWritePost * silent! %!xmllint --format --recover <afile>
