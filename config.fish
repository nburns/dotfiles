function prepend_to_path --description 'check path before adding to PATH'
    if [ -d $argv ]
        set -g -x PATH $argv $PATH
    end
end

function set_once --description 'caches expensive calls in universal var'
    if echo $argv[1] | grep -e '--clear' > /dev/null
        if not set -q SET_ONCE_VAR_NAMES
            return
        end

        for var in (echo $SET_ONCE_VAR_NAMES | tr ' ' \n | sort -u | awk NF)
            echo -e "clearing $var, value was:\\n\\t$$var"
            set -e $var
        end
        set -e SET_ONCE_VAR_NAMES
        return
    end

    set name $argv[1]
    set command $argv[2]

    set -U -x SET_ONCE_VAR_NAMES $SET_ONCE_VAR_NAMES $name
    set -U -x SET_ONCE_VAR_NAMES (echo $SET_ONCE_VAR_NAMES | tr ' ' \n | sort -u | tr \n ' ')

    if not set -q $name
        set -U -x $name (eval $command)
    end
end

if which brew > /dev/null
    set_once BREW_SHELL_ENV 'brew shellenv'
    eval $BREW_SHELL_ENV
end

prepend_to_path /opt/homebrew/opt/mysql@5.7/bin
prepend_to_path /opt/homebrew/bin
prepend_to_path /usr/libexec
prepend_to_path ~/.cargo/bin
prepend_to_path ~/bin
prepend_to_path ~/.local/bin

if not which python > /dev/null
    if which brew > /dev/null
        set_once PY_LIBEXEC "realpath (brew --prefix python)/libexec/bin"
        prepend_to_path $PY_LIBEXEC
    end
end

if which asdf >/dev/null
    set_once ASDF_INIT "echo (brew --prefix asdf)/asdf.fish"
    source $ASDF_INIT
end

if which docker > /dev/null; and uname | grep -i darwin > /dev/null
    set -g -x DOCKER_BUILDKIT 0
    set -g -x COMPOSE_DOCER_CLI_BUILD 0
end

if [ -e ~/.env.fish ]
    source ~/.env.fish
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

    if which fd > /dev/null
        set -g -x FZF_DEFAULT_COMMAND 'fd --ignore-file ~/.agignore --no-ignore-vcs'
    end
else
    alias ag "ag --case-sensitive --follow"
end

if [ -e ~/.tvnamer-config.json ]
    alias tvnamer "tvnamer -c ~/.tvnamer-config.json"
end

alias pytest 'pytest --log-cli-level=CRITICAL -sv'


set -g -x PAGER "less"
set -g -x TODAY (date "+%m-%d")
set -g -x GREP_OPTIONS
set -g -x LESS '-gFERXP%lB$ -j 10'

set -g -x ACK_PAGER cat
set -g -x ACK_PAGER_COLOR cat

set -g -x PYTHONDONTWRITEBYTECODE 'True'
set -g -x PYTHONWARNINGS "ignore"


if which pip > /dev/null
    set_once PIP_PACKAGES 'pip freeze'
    if echo $PIP_PACKAGES | grep ipdb > /dev/null
        set -g -x PYTHONBREAKPOINT ipdb.set_trace
    end
end

set -g -x HOMEBREW_NO_EMOJI 1
set -g -x HOMEBREW_NO_AUTO_UPDATE 1
set -g -x HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK 1
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
