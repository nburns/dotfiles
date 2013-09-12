function fish_prompt
	set old $status 
	if test $old != 0
		set_color red --bold
		echo "[ $old ]"
		set_color normal
	end
	printf '%s@%s %s%s%s%s>%s' $USER $current_hostname (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (set_color blue) (set_color normal)
end
