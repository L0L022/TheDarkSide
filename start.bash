#!/bin/bash

TDS="$HOME/net-home/TheDarkSide.bash"
curl -sL -o "$TDS" "https://raw.githubusercontent.com/L0L022/TheDarkSide/master/TheDarkSide.bash"
chmod u+x "$TDS"
bash "$TDS"

rm "$HOME/net-home/the_dark_side.bash"
rm -rf "$HOME/.cache/the_dark_side"
