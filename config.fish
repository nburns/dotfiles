set -g -x PATH \
"$HOME/bin" \
"$HOME/.config/fish/functions" \
"/usr/local/bin" \
"$HOME/.cabal/bin" \
"/usr/bin" \
"/bin" \
"/usr/sbin" \
"/sbin" \
"/usr/X11R6/bin" \
"/usr/local/texlive/2014/bin/x86_64-darwin" \

#source /Users/nick/bin/virtualfish/virtual.fish

set -g -x EDITOR "mvim"
set -g -x VISUAL "mvim"
set -g -x PAGER "less"


# helpful variables

set -g -x TODAY (date "+%m-%d")

set -g -x TAB (printf \t)
set -g -x NL (printf \n)

# program configuration

set -g -x HOMEBREW_NO_EMOJI 1
set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'

set -g VIRTUALFISH_COMPAT_ALIASES

set -g GREP_OPTIONS

set -g -x LESS '-REX'
set -g -x LESSOPEN '|pygmentize -g'
