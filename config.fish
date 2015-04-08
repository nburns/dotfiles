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

    prepend_to_path ~/bin\
                    /usr/local/bin\
                    ~/.cabal/bin\
                    /opt/X11/bin\
                    /usr/local/texlive/2014/bin/x86_64-darwin
    
    switch (uname)
        case 'Darwin'
            set -g -x LC_ALL 'en_US.UTF-8'
            set -g -x LANG 'en_US.UTF-8'
            set -g -x PYTHONDONTWRITEBYTECODE 'True'
            set -g -x HOMEBREW_NO_EMOJI 1
            set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'
            set -g -x VIM_APP_DIR (dirname (readlink /Applications/MacVim.app))
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
    
    set -g GREP_OPTIONS
    
    set -g -x LESS '-gFERXP%lB$'
    set -g -x LESSOPEN '|pygmentize -g'
    
    set -g -x ACK_PAGER_COLOR $PAGER

    function fish_greeting; end

    function fish_right_prompt
        set last $status
        if [ $last -ne 0 ]
            echo -n $last
        end
    end
    
    set -g -x _SETUPDONE 'true'
end
