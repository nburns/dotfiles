function args
    set i 1
	for arg in $argv
		echo "Arg #"$i" = "$argv[$i]
        set i (math $i + 1)
	end
end
