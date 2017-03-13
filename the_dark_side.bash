#!/bin/bash

last_release="$(git ls-remote --tags "https://github.com/L0L022/config_iut" | sed "s|.*refs/tags/\(.*\)$|\1|g" | sort -V | tail -n 1)"

if [ -z "$last_release" ]; then
  last_release="master"
fi

echo "$last_release"
mkdir -p "$HOME/.cache/"
curl -so "$HOME/.cache/start.bash" https://raw.githubusercontent.com/L0L022/config_iut/"$last_release"/start.bash
bash "$HOME/.cache/start.bash"
