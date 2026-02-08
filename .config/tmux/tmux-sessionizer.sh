#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    # selected=$(zoxide query -l | rg -v "Library" | awk '{ print substr($0,match($0,"/[^/]*$")+1) "\t" $0 }' | fzf --with-nth=1 --bind 'ctrl-x:execute:less {2}' --no-sort | awk -F'\t' '{print $2}')


    selected=$(wezterm-workspaces.sh | fzf --with-nth 5 --bind='enter:become(echo {1})'
)
fi

# echo $selected
# exit 0

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi


zoxide add $selected
tmux switch-client -t $selected_name
