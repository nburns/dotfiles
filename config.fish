if status --is-interactive; or status --is-login
    set GOPATH ~/go

    function prepend_to_path
        if [ -d $argv ]
            set -g -x PATH $argv $PATH
        end
    end

    prepend_to_path $GOPATH/bin

    prepend_to_path /usr/local/opt/python/libexec/bin
    prepend_to_path /usr/local/sbin
    prepend_to_path ~/bin
    prepend_to_path ~/.local/bin

    switch (uname)
        case 'Darwin'
            set -g -x LC_ALL 'en_US.UTF-8'
            set -g -x LANG 'en_US.UTF-8'
    end


    if [ -e /usr/libexec/java_home ]
        set -g -x JAVA_HOME (/usr/libexec/java_home)
        prepend_to_path "$JAVA_HOME"/bin
    end

    if [ (which rbenv) ]
        status --is-interactive; and source (rbenv init -|psub)
    end

    function always_bundle_exec
        alias "$argv[1]" "bundle exec $argv[1]"
    end

    always_bundle_exec rails
    always_bundle_exec rake
    always_bundle_exec papers
    alias rspec "bundle exec rspec --no-profile"

    if [ -e ~/.env ]
        function reload_env
            source ~/.env
        end
        reload_env
    end

    if [ -e  /Applications/MacVim.app ]
        set -g -x VIM_APP_DIR /Applications
    end

    if [ (which mvim) ]
        set -g -x EDITOR 'mvim -f'
        set -g -x VISUAL 'mvim -f'
    else
        set -g -x EDITOR vim
        set -g -x VISUAL vim
    end

    if [ -e ~/Documents/dotfiles/homebrew-access-token ]
        source ~/Documents/dotfiles/homebrew-access-token
    end

    if [ -e ~/.agignore ]
        alias ag="ag --case-sensitive --path-to-ignore ~/.agignore"
    else
        alias ag="ag --case-sensitive"
    end

    set -g -x PAGER "less"
    set -g -x TODAY (date "+%m-%d")
    set -g -x TAB (printf '\t')
    set -g -x NL (printf '\n')
    set -g -x GREP_OPTIONS
    set -g -x LESS '-gFERXP%lB$ -j 10'

    set -g -x ACK_PAGER cat
    set -g -x ACK_PAGER_COLOR cat

    set -g -x PYTHONDONTWRITEBYTECODE 'True'

    set -g -x HOMEBREW_NO_EMOJI 1
    set -g -x HOMEBREW_NO_AUTO_UPDATE 1
    set -g -x HOMEBREW_NO_INSTALL_CLEANUP 1
    set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'

    function fish_greeting; end

    function print_status_code
        set last $status
        if [ $last -ne 0 ]
            set_color red
            echo -n $last" "
            set_color normal
        end
    end


    function current_branch
        echo (git branch 2>&1 | sed -e '/*/!d' -e 's/* //g' -e '/fatal:/d')" "
        #echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')" "
    end



    function fish_prompt --description 'Write out the prompt'
        set _status (print_status_code)

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
end
