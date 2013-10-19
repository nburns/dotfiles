if status --is-login
	set -g -x EDITOR "wmate"
	set -g -x VISUAL "wmate"
	set -g -x PAGER "most"

	set -g -x BC_ENV_ARGS "$HOME/.bcrc"

	set -g -x TODAY (date "+%m-%d")

	set -g -x FUNCTIONS "$HOME/Documents/dotfiles/functions"
	set -g -x FISH_CONFIG "$HOME/.config/fish/config.fish"


	for file in (ls "$FUNCTIONS/setup")
		. "$FUNCTIONS/setup/$file"
	end
end