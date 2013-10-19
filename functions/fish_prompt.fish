function fish_prompt
	set -g -x last_status $status
	printf '%s@%s %s%s%s%s>%s' $USER (hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (set_color blue) (set_color normal)
end