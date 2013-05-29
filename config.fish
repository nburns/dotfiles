if status --is-login
	set fish_greeting
	
	set -g -x PATH ~/.config/fish/functions
	setup_path
	setup_color
	
	set -g -x EDITOR 'mate -w'
	set -g -x VISUAL 'mate -w'
	set -g -x PAGER 'most'
	
	set -g -x current_hostname (hostname)
	set -g -x today (date "+%m-%d")
	
	set -g -x CELLAR /usr/local/Cellar
	set -g -x HOMEBREW_NO_EMOJI 1

	function fish_prompt
		if test $status != 0
			set_color red
			echo "[$status]"
			set_color normal
		end
		printf '%s@%s %s%s%s%s>%s' $USER $current_hostname (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (set_color blue) (set_color normal)
	end

	function edit_fish
		open ~/.config/fish/config.fish
	end

	function audio
		sox -traw -r44100 -b16 -e unsigned-integer - -tcoreaudio $argv
	end
	
	function p
		pbpaste $argv
    end
        
    function c
        pbcopy $argv
    end
	
    function ip
        set external (curl -s http://ipecho.net/plain)
        set wired (ipconfig getifaddr en0)
        set wifi (ipconfig getifaddr en1)
		
        printf '%sLAN  :%s%s%s\n' (set_color red) (set_color blue) $wired (set_color normal)
        printf '%sWLAN :%s%s%s\n' (set_color red) (set_color cyan) $wifi (set_color normal)
        printf '%sEXT  :%s%s%s\n' (set_color red) (set_color green) $external (set_color normal)

    end
		
	function flac2alac
		for f in *.flac
			ffmpeg -i $f -acodec alac (basename $f .flac).m4a
		end
	end
	
	function shorten2alac
		for f in *.shn
			ffmpeg -i $f -acodec alac (basename $f .shn).m4a
		end
	end
	
	function cd..
		cd ..
	end
	
	function string_contains
		if echo $argv[1] | grep $argv[2] > /dev/null
			return 0
		else
			return 1
		end
	end
	
	function list_tail
		tail -n +2 $argv
	end
	
	function list_head
		head -n +1 $argv
	end
	
	function new
		touch $argv
		open $argv
	end
	
	function arguments
		for i in (seq (count $argv))
			echo "$argv[$i]"
		end
	end
		

end
