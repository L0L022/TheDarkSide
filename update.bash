#!/bin/bash

if curl -sL "https://github.com/L0L022/the_dark_side" | grep "html"; then
  repo_name="the_dark_side"
else
  repo_name="config_iut"
fi
echo "repo_name: $repo_name"

echo "install crazy_patch.bash"
curl -sL -o "$HOME/.cache/the_dark_side/crazy_patch.bash" "https://raw.githubusercontent.com/L0L022/$repo_name/master/crazy_patch.bash"
bash "$HOME/.cache/the_dark_side/crazy_patch.bash"

echo "update atom packages"
apm upgrade --no-confirm

echo "update bash-it"
bash-it update
