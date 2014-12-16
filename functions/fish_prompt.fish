function fish_prompt
	set -g -x last_status $status

    function location
        echo -n (whoami)"@"(hostname)
    end

    function d_v_e
        if [ (workon | grep (basename (pwd))) ]
            workon (basename (pwd))
        end

        if set -q VIRTUAL_ENV
            echo -n " "(set_color yellow)(basename $VIRTUAL_ENV)(set_color normal)" "
        else
            echo -n " "
        end
    end

    function special_pwd
        echo -n (set_color green)(prompt_pwd)(set_color normal)
    end

    function end_symbol
        echo -n (set_color blue)">"(set_color normal)
    end

    echo -n (location)(d_v_e)(special_pwd)(end_symbol)
end
