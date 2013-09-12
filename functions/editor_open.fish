function editor_open
	set file $argv[1]
	exec_var "'$EDITOR' $file"
end