#!/bin/bash

MODULE_PATH="$1"
SCRIPT_PATH="$MODULE_PATH/script.bash"

if [ ! -f "$MODULE_PATH/$SCRIPT_PATH" ]; then
	echo "No script found"
	exit 1
fi

source "$SCRIPT_PATH"
