#!/usr/bin/env fish

set $os_name (uname)
if echo $os_name | grep 'Darwin' > /dev/null
	# echo LINUX
	set -g -x $EDITOR nano
	set -g -x $VISUAL nano
else
	# echo OSX
end