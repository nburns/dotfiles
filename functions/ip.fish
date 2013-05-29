function ip
    set external (curl -s http://ipecho.net/plain)
    set wired (ipconfig getifaddr en0)
    set wifi (ipconfig getifaddr en1)
	
    printf '%sLAN  :%s%s%s\n' (set_color red) (set_color blue) $wired (set_color normal)
    printf '%sWLAN :%s%s%s\n' (set_color red) (set_color cyan) $wifi (set_color normal)
    printf '%sEXT  :%s%s%s\n' (set_color red) (set_color green) $external (set_color normal)

end