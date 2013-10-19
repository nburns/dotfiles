function fish_exec
	set execute
	for arg in $argv
		set execute "$execute $arg"
	end
	# echo $execute
	fish -c $execute
end