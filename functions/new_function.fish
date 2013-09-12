function new_function
	set function_name $argv[1]
	set file_name "$FUNCTIONS/$argv[1].fish"
	# echo $file_name
	printf 'function %s\n\t\nend' $function_name > $file_name
	open $file_name
end
