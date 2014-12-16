set -g VIRTUALFISH_COMPAT_ALIASES

source /Users/nick/bin/virtualfish/virtual.fish

set -g -x EDITOR "mvim"
set -g -x VISUAL "mvim"
set -g -x PAGER "vimpager"

set -g -x TODAY (date "+%m-%d")

set -g -x FUNCTIONS "$HOME/Documents/dotfiles/functions"
set -g -x FISH_CONFIG "$HOME/.config/fish/config.fish"

set -g -x TAB (printf \t)
set -g -x NL (printf \n)

set -g -x HOMEBREW_NO_EMOJI 1
set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'

set GREP_OPTIONS

set -g -x PATH "$HOME/.config/fish/functions"
append_to_path "/usr/local/bin"
append_to_path "$HOME/.cabal/bin"
append_to_path "$HOME/bin"
append_to_path "/usr/bin"
append_to_path "/bin"
append_to_path "/usr/sbin"
append_to_path "/sbin"
append_to_path "/usr/X11R6/bin"
append_to_path "/usr/local/texlive/2014/bin/x86_64-darwin"




