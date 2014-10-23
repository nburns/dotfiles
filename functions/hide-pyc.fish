function hide-pyc
	for f in (find . -iname '*.pyc')
		setfile -a V $f
	end
end