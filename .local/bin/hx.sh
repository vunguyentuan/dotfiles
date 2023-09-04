#!/usr/bin/env sh

tty=$(tty)
hostname=$(hostname | tr '[:upper:]' '[:lower:]')
pwd=$(pwd)
file_path=$1

pane_id=$(wezterm cli list --format json | jq --arg tty "$tty" --arg opening_cwd "file://$hostname$pwd" --arg file_path "file://$hostname$file_path" -r '.[] | .cwd as $running_cwd | select((.tty_name != $tty) and (.title | startswith("hx")) and (($opening_cwd | contains($running_cwd)) or ($file_path | contains($running_cwd)))) | .pane_id')
if [ -z "$pane_id" ]; then
    /opt/homebrew/bin/hx $1
else
    if [ -n "$file_path" ]; then
        echo ":open ${file_path}\r" | wezterm cli send-text --pane-id $pane_id --no-paste
    else
        echo ":open ${pwd}\r" | wezterm cli send-text --pane-id $pane_id --no-paste
    fi
    wezterm cli activate-pane --pane-id $pane_id
fi
