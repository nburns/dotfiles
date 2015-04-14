if [ "$_SETUPDONE" != 'true' ] ; or status --is-login
    function error
        echo $argv > /dev/stderr
    end

    function prepend_to_path
        for arg in $argv
            if [ -d $arg ]
                set -g -x PATH $arg $PATH
            end
        end
    end

    prepend_to_path ~/bin /usr/local/bin ~/.cabal/bin /opt/X11/bin\
                    /usr/local/texlive/2014/bin/x86_64-darwin
    
    switch (uname)
        case 'Darwin'
            set -g -x LC_ALL 'en_US.UTF-8'
            set -g -x LANG 'en_US.UTF-8'
            set -g -x PYTHONDONTWRITEBYTECODE 'True'
            set -g -x HOMEBREW_NO_EMOJI 1
            set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'
            if [ -e  /Applications/MacVim.app ]
                set -g -x VIM_APP_DIR (dirname (readlink /Applications/MacVim.app))
            end
        case 'Linux'
            if [ -d ~/.linuxbrew ]
                set -g -x PATH ~/.linuxbrew/bin $PATH
                set -g -x MANPATH ~/.linuxbrew/share/man $MANPATH
                set -g -x INFOPATH ~/.linuxbrew/share/info $INFOPATH
            end
            if [ (which fish) ]
                set -g -x SHELL (which fish)
            end
            alias ls "ls --hide='*.pyc'"
    end

    if [ (which mvim) ]
        set -g -x VISUAL mvim
    else
        set -g -x VISUAL vim
    end
    
    if [ -d ~/bin/virtualfish ]
        pushd ~/bin/virtualfish
        eval (python -m virtualfish compat_aliases auto_activation)
        popd
    else
        error 'could not find ~/.virtualfish'
    end
    
    set -g -x PAGER "less"
    set -g -x TODAY (date "+%m-%d")
    set -g -x TAB (printf \t)
    set -g -x NL (printf \n)
    set -g -x GREP_OPTIONS
    set -g -x LESS '-gFERXP%lB$'
    set -g -x LESSOPEN '|pygmentize -g'
    set -g -x ACK_PAGER_COLOR $PAGER # ack output gets paged and is colourful

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

    #functions --copy fish_prompt old_fish_prompt

    #function fish_prompt
    #    status_code
    #    #current_branch
    #    virtualenv
    #    old_fish_prompt
    #end


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
