if status --is-interactive
    switch (uname)
        case 'Darwin'
            set -g -x PATH "$HOME/bin"\
                "/usr/local/bin"\
                "/usr/local/texlive/2014/bin/x86_64-darwin"\
                $PATH
    
            set -g -x LC_ALL 'en_US.UTF-8'
            set -g -x LANG 'en_US.UTF-8'
            
            set -g -x PYTHONDONTWRITEBYTECODE 'True'
            
            set -g -x EDITOR "mvim"
            set -g -x VISUAL "mvim"
            set -g -x VIM_APP_DIR /opt/homebrew-cask/Caskroom/macvim/7.4-73/MacVim-snapshot-73

            
            set -g -x HOMEBREW_NO_EMOJI 1
            set -g -x HOMEBREW_CASK_OPTS '--appdir=/Applications'

        case 'Linux'
            if [ -d ~/bin ]
                set -g -x PATH ~/bin $PATH
            end

            set -g -x EDITOR "vim"
            set -g -x VISUAL "vim"
            
    end
    
    
    if [ -d ~/bin/virtualfish ]
        pushd ~/bin/virtualfish
        eval (python -m virtualfish compat_aliases)
        popd
    else
        echo 'could not find ~/.virtualfish'
    end
    
    set -g -x PAGER "less"
    
    
    # helpful variables
    
    set -g -x TODAY (date "+%m-%d")
    
    set -g -x TAB (printf \t)
    set -g -x NL (printf \n)
    
    # program configuration
    
    set -g GREP_OPTIONS
    
    set -g -x LESS '-gFERXP%lB$'
    set -g -x LESSOPEN '|pygmentize -g'
    
    set -g -x ACK_PAGER_COLOR $PAGER
    
    
    set -g -x base03 002b36
    set -g -x base02 073642
    set -g -x base01 586e75
    set -g -x base00 657b83
    set -g -x base0 839496
    set -g -x base1 93a1a1
    set -g -x base2 eee8d5
    set -g -x base3 fdf6e3
    set -g -x yellow b58900
    set -g -x orange cb4b16
    set -g -x red dc322f
    set -g -x magenta d33682
    set -g -x violet 6c71c4
    set -g -x blue 268bd2
    set -g -x cyan 2aa198
    set -g -x green 859900
    
    function fish_greeting; end
end
