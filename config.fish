set -g VIRTUALFISH_COMPAT_ALIASES

source /Users/nick/bin/virtualfish/virtual.fish

set -g -x EDITOR "mvim"
set -g -x VISUAL "mvim"
set -g -x PAGER "most"

set -g -x TODAY (date "+%m-%d")

set -g -x FUNCTIONS "$HOME/Documents/dotfiles/functions"
set -g -x FISH_CONFIG "$HOME/.config/fish/config.fish"


for file in (ls "$FUNCTIONS/setup")
	source "$FUNCTIONS/setup/$file"
end
