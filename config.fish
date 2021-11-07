set GOPATH ~/go

function prepend_to_path --description 'check path before adding to PATH'
    if [ -d $argv ]
        set -g -x PATH $argv $PATH
    end
end

function set_once --description 'caches expensive calls in universal var'
    set name $argv[1]
    set command $argv[2]
    if not set -q $name
        set -U -x $name (eval $command)
    end
end

if which brew > /dev/null
    set_once BREW_SHELL_ENV 'brew shellenv'
    eval $BREW_SHELL_ENV
end

prepend_to_path $GOPATH/bin
prepend_to_path /usr/local/opt/python/libexec/bin
prepend_to_path ~/bin
prepend_to_path ~/.local/bin
prepend_to_path /usr/local/opt/python@3.9/libexec/bin

if which rbenv > /dev/null
    status --is-interactive; and source (rbenv init - | psub)

    alias papers 'bundle exec papers'
    alias rails 'bundle exec rails'
    alias rake 'bundle exec rake'
    alias rspec 'bundle exec rspec --no-profile'

    if which brew > /dev/null
        set_once OPEN_SSL_DIR "brew --prefix openssl@1.1"
        set -g -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=$OPEN_SSL_DIR"
    end
end

if which asdf >/dev/null
    set_once ASDF_INIT "echo (brew --prefix asdf)/asdf.fish"
    source $ASDF_INIT
end

if [ -e ~/.env ]
    source ~/.env
end

if which brew > /dev/null
    set_once VIM_APP_DIR "realpath (brew --prefix macvim)"
end

if which mvim > /dev/null
    set -g -x EDITOR mvim
    set -g -x VISUAL mvim
else
    set -g -x EDITOR vim
    set -g -x VISUAL vim
end

if [ -e ~/Documents/dotfiles/homebrew-access-token ]
    source ~/Documents/dotfiles/homebrew-access-token
end

if [ -e ~/.agignore ]
    alias ag "ag --case-sensitive --follow --path-to-ignore ~/.agignore"
else
    alias ag "ag --case-sensitive --follow"
end

set -g -x PAGER "less"
set -g -x TODAY (date "+%m-%d")
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
        printf $last" "
        set_color normal
    end
end

function current_branch
    echo (git branch 2>&1 | sed -e '/*/!d' -e 's/* //g' -e '/fatal:/d')" "
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
