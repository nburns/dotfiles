if [ "$_SETUPDONE" != 'true' ] ; or status --is-login
    function prepend_to_path
        set valid_paths
        for path in $argv
            if [ -d $path ]
                echo $path
                set valid_paths $valid_paths $path
            end
        end
        set -g -x PATH $valid_paths $PATH
    end

    prepend_to_path ~/bin

    switch (uname)
        case 'Darwin'
            set -g -x LC_ALL 'en_US.UTF-8'
            set -g -x LANG 'en_US.UTF-8'
    end
    
    if [ -e  /Applications/MacVim.app ]
        set -g -x VIM_APP_DIR (dirname (readlink /Applications/MacVim.app))
    end

    if [ -d ~/.linuxbrew ]
        set -g -x PATH ~/.linuxbrew/bin $PATH
        set -g -x MANPATH ~/.linuxbrew/share/man $MANPATH
        set -g -x INFOPATH ~/.linuxbrew/share/info $INFOPATH
    end

    if [ (which mvim) ]
        set -g -x VISUAL mvim
    else
        set -g -x VISUAL vim
    end

    if [ -e ~/Documents/dotfiles/homebrew-access-token ]
        source ~/Documents/dotfiles/homebrew-access-token
    end
    
    set -g -x PAGER "less"
    set -g -x TODAY (date "+%m-%d")
    set -g -x TAB (printf \t)
    set -g -x NL (printf \n)
    set -g -x GREP_OPTIONS
    set -g -x LESS '-gFERXP%lB$'
    set -g -x LESSOPEN '|pygmentize -g'
    set -g -x ACK_PAGER_COLOR $PAGER # ack output gets paged and is colourful
    set -g -x PYTHONDONTWRITEBYTECODE 'True'
    set -g -x HOMEBREW_NO_EMOJI 1
    set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'


    function fish_greeting; end

    function status_code
        set last $status
        if [ $last -ne 0 ]
            set_color red
            echo -n $last" "
            set_color normal
        end
    end
    

    function current_branch
        echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')" "
    end
   

    function virtualenv
        if set -q VIRTUAL_ENV 
            echo -n (basename $VIRTUAL_ENV)" "
        end
    end

    function autogo --on-variable PWD --description "check PWD, set GOPATH and PATH"
        if pwd | grep ~/outbound/outbound  >/dev/null
            set -g -x GOPATH (pwd)
            if not echo $PATH | grep ~/outbound/outbound >/dev/null
                set -g -x PATH ~/outbound/outbound/bin $PATH
            end
        end
    end


    function fish_prompt --description 'Write out the prompt'
        set _status (status_code)
    
        # Just calculate these once, to save a few cycles when displaying the prompt
        if not set -q __fish_prompt_hostname
            set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
        end
    
        if not set -q __fish_prompt_normal
            set -g __fish_prompt_normal (set_color normal)
        end
    
        switch $USER 
            case root 
                if not set -q __fish_prompt_cwd
                    if set -q fish_color_cwd_root
                        set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
                    else
                        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
                    end
                end 
                echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '# '
    
            case '*' 
                if not set -q __fish_prompt_cwd
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
                end 
                echo -n -s $_status (current_branch) "$USER" @ "$__fish_prompt_hostname" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '> '
        end
    end



    set -g _SETUPDONE 'true'
end
