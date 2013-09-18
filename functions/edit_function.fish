function edit_function
	set function_file "$FUNCTIONS/$argv[1].fish"
	wmate $function_file
	reload $function_file
end