""""""""""""""""""""""""""
" Special Options
""""""""""""""""""""""""""
" use pathogen
call pathogen#infect()

" printing on OS X
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ .\ +\ v:shell_error

""""""""""""""""""""""""""
" Text Display Options
""""""""""""""""""""""""""
" enable syntax highlighting
syntax enable

" set light background in gui dark in terminal
if has("gui_running")
	set guifont=Menlo\ Regular:h13
	let g:solarized_contrast="high"
    set background=dark
	colorscheme solarized
else
    set background=dark
	colorscheme solarized
endif

" highlight search terms
set hlsearch

" search incrementally
set incsearch

" show bracket pairing
set showmatch

" blink on pairing
set mat=3

" show current position
set ruler

" break lines into 100 chars
" set lbr
" set tw=100

""""""""""""""""""""""""""
" Interface  Options
""""""""""""""""""""""""""
" tab options
set tabstop=4
set shiftwidth=4

" use system clipboard on OS X
" enable mouse
set mouse=a
set ttymouse=xterm2

" command bar height
set cmdheight=1

" ennable line numbers
set number

" supress error alerts
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" enable regular expressions
set magic

" enable autoindent and smartindent
set autoindent smartindent

" disable folding
set nofoldenable

" show a nice status line
set laststatus=2
set statusline=\ \ %F%m%r%h%w\ %=%55(%{strftime('%b\%e,\ \%I:%M\ %p')}\ %5l,%-6(%c%V%)\ %)

""""""""""""""""""""""""""
" Keyboard Control Options
""""""""""""""""""""""""""
" map command to meta
if has("mac") || has("macunix")
        nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" delete extra whitespace
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" ss to toggle spelling
map <leader>ss :setlocal spell!<cr>

" fix backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" swap j with k
noremap j k
noremap k j

""""""""""""""""""""""""""
" File Options
""""""""""""""""""""""""""
" convert tabs to spaces
set expandtab

" use smarttabs
set smarttab

" update externaly edited files
set autoread

" use utf8 text encoding
set encoding=utf8

" disable local backup
set nobackup
set nowb
set noswapfile

" use unix file format
set ffs=unix,dos,mac

" remember last open position of a buffer
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%

" file size helper function
function! FileSize()
	let bytes = getfsize(expand("%:p"))
	if bytes <= 0
		return ""
	endif
	if bytes < 1024
		return bytes . "B"
	else
		return (bytes/1024) . "KB"
	endif
endfunction
