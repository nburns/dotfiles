function fish_right_prompt
	set git_info
	if test -d .git
		set branch (git rev-parse --abbrev-ref HEAD)
		set repo (git rev-parse --show-toplevel)
		set repo (basename $repo)
		set git_info "$branch:$repo"
	end
	printf '%s' $git_info
	
	if test $last_status != 0
		set_color $fish_color_error
		printf '    [ %s ]' $last_status
		set_color normal
	end
end