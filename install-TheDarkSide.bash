#!/bin/bash

last_release="$(git ls-remote --tags "https://github.com/L0L022/TheDarkSide" | sed "s|.*refs/tags/\(.*\)$|\1|g" | sort -V | tail -n 1)"

if [ -z "$last_release" ]; then
  last_release="master"
fi

echo "$last_release"
mkdir -p "$HOME/.cache/TheDarkSide/"
curl -so "$HOME/.cache/TheDarkSide/install.bash" https://raw.githubusercontent.com/L0L022/TheDarkSide/"$last_release"/script/install.bash
bash "$HOME/.cache/TheDarkSide/install.bash"
