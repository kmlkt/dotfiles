~/.config/scripts/sync-config.sh
cd ~/Dev
for subdir in ./*/; do
  if [[ -d "$subdir" ]]; then # Check if it's a directory
    echo "Processing subdirectory: $subdir"
    cd $subdir
        git fetch --all
        git pull --all
    cd ..
  fi
done
