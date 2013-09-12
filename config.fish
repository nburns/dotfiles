if status --is-login
	set -g -x EDITOR "wmate"
	set -g -x VISUAL "wmate"
	set -g -x PAGER "most"

	set -g -x BC_ENV_ARGS "$HOME/.bcrc"

	set -g -x current_hostname (hostname)
	set -g -x today (date "+%m-%d")
	
	set -g -x BASH_PATH (bash_path)

	set -g -x FUNCTIONS "$HOME/Documents/dotfiles/functions"
	set -g -x FISH_CONFIG "$HOME/.config/fish/config.fish"

	append_to_path "$HOME/.config/fish/functions"

	setup_path
	setup_color
	setup_homebrew
	
	if test -f "$HOME/.config/fish/functions/setup_private.fish"
		setup_private
	end



end