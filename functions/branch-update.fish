function branch-update
    git checkout stage
    git fetch upstream
    git rebase upstream/stage
    git checkout $argv[1]
    git rebase stage
end
