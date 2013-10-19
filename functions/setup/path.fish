#!/usr/bin/env fish
set -g -x PATH "$HOME/.config/fish/functions"
append_to_path "$HOME/.cabal/bin"
append_to_path "$HOME/bin"
# MacPorts
# append_to_path "/opt/local/bin"
# append_to_path "/opt/local/sbin"
append_to_path "/opt/homebrew/opt/ruby/bin"
append_to_path "/opt/homebrew/bin"
append_to_path "/usr/bin"
append_to_path "/bin"
append_to_path "/usr/sbin"
append_to_path "/sbin"
append_to_path "/usr/X11R6/bin"
append_to_path "/usr/local/texlive/2012/bin/x86_64-darwin"

