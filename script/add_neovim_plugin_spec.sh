#!/user/bin/env bash

# Add a new neovim plugin spec file

DIR="${HOME}/.config/nvim/lua/plugin"
FILE="$DIR/$1.lua"
TEMP="$DIR/template"

if [[ ! -f $FILE ]]; then
    printf "$(<$TEMP)" "$(pbpaste)" >"$FILE"
else
    echo "ERROR: file $FILE already exists"
    exit 1
fi