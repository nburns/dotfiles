function git-rebase
    if git diff --quiet
        set branch (git rev-parse --abbrev-ref HEAD)
        git checkout stage
        git fetch upstream
        git rebase upstream/stage
        git checkout $branch
        git rebase stage
    else
        echo commit your changes
    end
end
