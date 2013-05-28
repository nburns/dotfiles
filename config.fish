if status --is-login
	set -g -x PATH /usr/local/share/python ~/.cabal/bin /Users/nick/bin /usr/local/lib/python2.7/site-packages /usr/local/share/python /usr/local/bin /usr/bin /bin /usr/sbin /sbin /usr/local/Cellar/fish/2.0.0/bin /usr/X11R6/bin /usr/local/texlive/2012/bin/x86_64-darwin /usr/local/Cellar/ruby/2.0.0-p0/bin


	set -g -x BROWSER 'open -a Google Chrome'
	set -g -x EDITOR 'mate -w'
	set -g -x VISUAL 'mate -w'
	set -g -x PAGER less
	set -g -x default-terminal "xterm"
	set -g -x CELLAR /usr/local/Cellar
	#set -g -x MANPATH $HOMEBREWDIR/share/man

	set fish_greeting
	set -g -x current_hostname (hostname)
	set -g -x today (date "+%m-%d")
	
	set -g -x HOMEBREW_NO_EMOJI 1
	
	set -g -x LC_CTYPE "utf-8"

	set -g -x fish_color_autosuggestion normal
	set -g -x fish_color_command red
	set -g -x fish_color_comment normal
	set -g -x fish_color_cwd green
	set -g -x fish_color_cwd_root red
	set -g -x fish_color_error red --bold
	set -g -x fish_color_escape blue
	set -g -x fish_color_history_current blue
	set -g -x fish_color_match red --bold
	set -g -x fish_color_normal white
	set -g -x fish_color_operator blue
	set -g -x fish_color_param yellow
	set -g -x fish_color_quote cyan
	set -g -x fish_color_redirection normal
	set -g -x fish_color_search_match --background=magenta
	set -g -x fish_color_valid_path --underline
	set -g -x fish_pager_color_completion normal
	set -g -x fish_pager_color_description normal
	set -g -x fish_pager_color_prefix red --bright
	set -g -x fish_pager_color_progress green

	# function java
	# 	java -enableassertions $argv
	# end


	function fish_prompt
		printf '%s@%s %s%s%s%s>%s' $USER $current_hostname (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (set_color blue) (set_color normal)
	end

	function edit_fish
		open ~/.config/fish/config.fish
	end

	function haskell
		ghci $argv
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
	
	function lsblk
		diskutil list
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

end
