function string_contains
	if echo $argv[1] | grep $argv[2] > /dev/null
		return 0
	else
		return 1
	end
end