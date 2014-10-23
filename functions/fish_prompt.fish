function fish_prompt
	set -g -x last_status $status
    
    if set -q VIRTUAL_ENV
        set -g VENV " "(basename $VIRTUAL_ENV)" "
    else
        set -g VENV " "
    end

    echo -n (whoami)"@"(hostname)$VENV(set_color green)(prompt_pwd)(set_color normal)">"
end
