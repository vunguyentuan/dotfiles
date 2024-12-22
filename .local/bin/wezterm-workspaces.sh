#!/bin/bash

dirs=$(fd . ~/Projects/wisory ~/Projects/Personal  --min-depth 1 --max-depth 1 --type d -x echo {/} {})
echo "$dirs"
echo "Home $HOME"
echo "Dotfiles $HOME/dotfiles"
echo ".config $HOME/.config"
