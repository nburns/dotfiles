if status --is-interactive
    function error
        echo $argv > /dev/stderr
    end

    function prepend_to_path
        for arg in $argv
            if [ -d $arg ]
                set -g -x PATH $argv $PATH
            end
        end
    end

    prepend_to_path\
        ~/bin\
        /usr/local/texlive/2014/bin/x86_64-darwin\
        /usr/local/bin\
        ~/.cabal/bin\
        /opt/X11/bin/
    
    switch (uname)
        case 'Darwin'
            set -g -x LC_ALL 'en_US.UTF-8'
            set -g -x LANG 'en_US.UTF-8'
            
            set -g -x PYTHONDONTWRITEBYTECODE 'True'
            
            set -g -x VIM_APP_DIR /opt/homebrew-cask/Caskroom/macvim/7.4-73/MacVim-snapshot-73

            set -g -x HOMEBREW_NO_EMOJI 1
            set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'
    end

    if [ (which mvim) ]
        set -g -x VISUAL mvim
    else
        set -g -x VISUAL vim
    end
    
    
    if [ -d ~/bin/virtualfish ]
        pushd ~/bin/virtualfish
        eval (python -m virtualfish compat_aliases)
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
            set_color red; echo -n $last; set_color normal
        end
    end
    
end
