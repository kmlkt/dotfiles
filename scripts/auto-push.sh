~/.config/scripts/sync-config.sh
cd ~/Dev
for subdir in ./*/; do
  if [[ -d "$subdir" ]]; then # Check if it's a directory
    echo "Processing subdirectory: $subdir"
    cd $subdir
        ~/.config/scripts/commit-n-push.sh
    cd ..
  fi
done
