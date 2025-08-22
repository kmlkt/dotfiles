cd ~/.config
git fetch origin
if [[ `git status --porcelain` ]]; then
    git add -A
    git commit -m "auto commit"
fi
git push origin master
git pull origin master
