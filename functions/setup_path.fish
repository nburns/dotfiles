function setup_path
	set -g -x PATH
	append_to_path ~/.config/fish/functions
	append_to_path ~/.cabal/bin
	append_to_path ~/bin
	append_to_path /usr/local/bin
	append_to_path /usr/local/sbin
	append_to_path /usr/bin
	append_to_path /usr/sbin
	append_to_path /bin
	append_to_path /sbin
	append_to_path /usr/X11R6/bin
	append_to_path /usr/local/texlive/2012/bin/x86_64-darwin
	append_to_path /usr/local/share/npm/bin
	append_to_path /usr/local/mysql/bin
end