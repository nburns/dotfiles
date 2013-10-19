function edit_function
	set function_name $argv[1]
	set function_name (echo $function_name | sed -e 's/.fish//')

	set function_file "$FUNCTIONS/$function_name.fish"
	if test -f $function_file
	else
		printf 'function %s\n\t\nend' $function_name > $function_file
	end

	edit $function_file
	reload $function_file
end