function web
	set args
	for arg in $argv
		set args " $args $arg"
	end
	# if test -f $args
		open -a /Applications/Google\ Chrome.app/ $args
end