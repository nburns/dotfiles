function fish_right_prompt

	
	if test $last_status != 0
		set_color $fish_color_error
		printf '[ %s ] ' $last_status
		set_color normal
	end
	
end
