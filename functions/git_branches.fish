function git_branches
	git for-each-ref --sort=-committerdate refs/heads/
end