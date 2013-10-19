function get_music
	cd ~/Music
	wget -nc -r -A "*.flac, *.m3u, *.jpg, *.jpeg, *.txt, *.cue, *.log, .*mp3" "http://37.235.53.107:9000"
end