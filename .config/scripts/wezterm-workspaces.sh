#!/bin/bash

dirs=$(find -L ~/Projects/Govtech ~/Projects/wisory ~/Projects/Personal ~/.config  -mindepth 1 -maxdepth 1 -type d)
base_dir="~/"
home=$HOME
workspaces=$(echo "$dirs" | awk -F/ '{print $0 " $ " $(NF-1) " 󰳠  " $NF}')
workspaces="$base_dir \$ Home
$home/dotfiles \$ Dotfiles
$workspaces"
echo "$workspaces"
