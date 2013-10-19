function append_to_path
	# echo "appending \"$argv[1]\" to path"
	if test -d $argv[1]
		set -g -x PATH $PATH $argv[1]
	else
		echo "Could not add \"$argv[1]\" to path"
	end
end