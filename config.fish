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

if [ -d ~/.virtualfish ]
    set -g VIRTUALFISH_COMPAT_ALIASES
    source ~/.virtualfish/virtual.fish
    source ~/.virtualfish/auto_activation.fish
else
    echo 'could not find ~/.virtualfish'
end

set -g -x LC_ALL 'en_US.UTF-8'
set -g -x LANG 'en_US.UTF-8'

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

set -g GREP_OPTIONS

set -g -x LESS '-gFERXP%lB$'
set -g -x LESSOPEN '|pygmentize -g'

set -g -x ACK_PAGER_COLOR $PAGER
