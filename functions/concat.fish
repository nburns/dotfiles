function concat
	set string
	for arg in $argv
		set string "$string $arg "
	end
	echo $string
end