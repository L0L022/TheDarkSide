#!/bin/bash

script="$TDS/user-config.bash"

echo "install user-config.bash"
curl -sL -o "$script" "https://raw.githubusercontent.com/L0L022/TheDarkSide/master/script/user-config.bash"
chmod u+x "$script"
bash -i "$script"

echo "update atom packages"
apm upgrade --no-confirm

echo "update bash-it"
bash-it update
