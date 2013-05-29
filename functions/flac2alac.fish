function flac2alac
	for f in *.flac
		ffmpeg -i $f -acodec alac (basename $f .flac).m4a
	end
end