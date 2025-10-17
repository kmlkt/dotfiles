if [ -d ".git" ]; then
    git fetch --all
    if [[ `git status --porcelain` ]]; then
        git add -A
        git commit -m "auto commit"
    fi
    git push --all
fi
