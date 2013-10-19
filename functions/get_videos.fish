function get_videos
	cd ~/Movies
	wget -nc -r -nd -A "*.mkv, *.mp4, *.avi" "http://37.235.53.107:9000"
	cd -
end