function audio
	sox -traw -r44100 -b16 -e unsigned-integer - -tcoreaudio $argv
end