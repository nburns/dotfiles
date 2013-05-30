if status --is-login
	set fish_greeting
	
	set -g -x PATH ~/.config/fish/functions
	
	setup_path
	setup_color
	setup_private
	
	set -g -x EDITOR 'mate -w'
	set -g -x VISUAL 'mate -w'
	set -g -x PAGER 'most'
	
	set -g -x current_hostname (hostname)
	set -g -x today (date "+%m-%d")
	
	function fish_prompt
		if test $status != 0
			set_color red
			echo "[$status]"
			set_color normal
		end
		printf '%s@%s %s%s%s%s>%s' $USER $current_hostname (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (set_color blue) (set_color normal)
	end

	function edit_fish
		open ~/.config/fish/config.fish
	end

	function cd..
		cd ..
	end

	function new
		touch $argv
		open $argv
	end

end
