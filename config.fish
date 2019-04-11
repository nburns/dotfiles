if [ "$_SETUPDONE" != 'true' ] ; or status --is-login
    function prepend_to_path
        set valid_paths
        for path in $argv
            if [ -d $path ]
                set valid_paths $valid_paths $path
            end
        end
        set -g -x PATH $valid_paths $PATH
    end

    prepend_to_path ~/bin
    prepend_to_path /usr/local/opt/ruby/bin
    prepend_to_path /usr/local/lib/ruby/gems/2.6.0/bin
    prepend_to_path /usr/local/opt/python@2/bin
    prepend_to_path /usr/local/opt/python@2/libexec/bin

    if [ (which yarn) ]
        prepend_to_path (yarn global bin)
    end

    switch (uname)
        case 'Darwin'
            set -g -x LC_ALL 'en_US.UTF-8'
            set -g -x LANG 'en_US.UTF-8'
    end

    if [ -z "$FONTCONFIG_PATH" -a -d /opt/X11/lib/X11/fontconfig ]
        set -g -x FONTCONFIG_PATH /opt/X11/lib/X11/fontconfig
    end
    
    if [ -e  /Applications/MacVim.app ]
        set -g -x VIM_APP_DIR /Applications
    end

    if [ -d ~/.linuxbrew ]
        set -g -x PATH ~/.linuxbrew/bin $PATH
        set -g -x MANPATH ~/.linuxbrew/share/man $MANPATH
        set -g -x INFOPATH ~/.linuxbrew/share/info $INFOPATH
    end

    if [ (which mvim 2>&1 >/dev/null) ]
        set -g -x VISUAL mvim
    else
        set -g -x VISUAL vim
    end

    if [ -e ~/Documents/dotfiles/homebrew-access-token ]
        source ~/Documents/dotfiles/homebrew-access-token
    end

    set -g -x PAGER "less"
    set -g -x TODAY (date "+%m-%d")
    set -g -x TAB (printf '\t')
    set -g -x NL (printf '\n')
    set -g -x GREP_OPTIONS
    set -g -x LESS '-gFERXP%lB$ -j 10'
    set -g -x LESSOPEN '|pygmentize -g'
    set -g -x ACK_PAGER_COLOR $PAGER # ack output gets paged and is colourful
    set -g -x PYTHONDONTWRITEBYTECODE 'True'
    set -g -x HOMEBREW_NO_EMOJI 1
    set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'

    if set -q GOPATH
        if [ -e "$GOPATH/bin" ]
            prepend_to_path "$GOPATH"bin
        end
    end


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
        echo (git branch 2>&1 | grep '*' | sed 's/* //g' | sed 's/fatal: Not a git repository (or any of the parent directories): .git//g')" "
        #echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')" "
    end
   

    function virtualenv
        if set -q VIRTUAL_ENV 
            echo -n (basename $VIRTUAL_ENV)" "
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
