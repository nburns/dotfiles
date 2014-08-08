function git-rebase
    set branch (git rev-parse --abbrev-ref HEAD)
    git checkout stage
    git fetch upstream
    git rebase upstream/stage
    git checkout $branch
    git rebase stage
end
