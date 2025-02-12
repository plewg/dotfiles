#!/usr/bin/env bash

declare vscode_backup_dir="${HOME}/Projects/dotfiles/vscode"
cp "${HOME}/Library/Application Support/Code/User/"{keybindings.json,settings.json} "${vscode_backup_dir}/"
code --list-extensions >"${vscode_backup_dir}/extensions.txt"
