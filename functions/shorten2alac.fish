function shorten2alac
	for f in *.shn
		ffmpeg -i $f -acodec alac (basename $f .shn).m4a
	end
end