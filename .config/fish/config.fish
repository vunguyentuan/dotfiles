if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

set -gx EDITOR "nvim" # or "vim", or "code", etc.

# export GPG_TTY=$(tty)
# export gpg tty for gpg-agent
set -gx GPG_TTY (tty)

set -gx NNN_OPENER "nnn-hx.sh"
set -Ux FZF_TMUX_OPTS "-p 55%,60%"

# fzf
set -Ux FZF_DEFAULT_COMMAND "fd --type file --hidden --no-ignore"


# alias
alias nvm="fnm"
alias vim="nvim"
alias v="nvim"
alias d="npm run dev"
alias s="npm run start"
alias b="npm run build"
alias cat="bat"
alias tree="eza --tree"
alias ls="eza"
alias docker-up="colima start"
alias php_decode="php $HOME/Projects/Temp/PHPDeobfuscator/index.php -f"

if test (uname) = Darwin
  alias gaws="~/projects/govtech/ctsg-infra-ops/ops/ctsg_remote_access.sh -u vu_nguyen -e dev -a power"
  alias cdbdev="~/projects/govtech/ctsg-infra-ops/ops/ctsg_remote_access.sh -u vu_nguyen -e dev -a power -d"
  alias config='/opt/homebrew/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
else
  alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
end

# bun
set -Ux BUN_INSTALL "$HOME/.bun"
fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/.local/bin"

# rust
fish_add_path "$HOME/.cargo/bin"

# android
fish_add_path "$HOME/Library/Android/sdk/platform-tools"


if test (uname) = Darwin
  # python
  fish_add_path "$(brew --prefix python)/libexec/bin"
  # php
  fish_add_path "/Applications/MAMP/bin/php/php8.2.0/bin"
  fish_add_path /Applications/MAMP/bin/php
  # aws cli
  fish_add_path "$HOME/Library/Python/3.11/bin"
  # pnpm
  set -gx PNPM_HOME $HOME/Library/pnpm
  set -gx PATH "$PNPM_HOME" $PATH
  # pnpm end
end


# aws cli
# set -gx AWS_CLI_HOME $HOME/aws-cli
# set -gx PATH "$AWS_CLI_HOME" $PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f $HOME/miniconda3/bin/conda
#     eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# end
# <<< conda initialize <<<
#

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

zoxide init fish | source

# ~/.tmux/plugins
fish_add_path $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin

# custom functions
function lf-pick --description 'lf file picker'
    if ! type -q lf
        echo "lf not installed"
    end

    set -l TEMP (mktemp)
    lf -selection-path=$TEMP
    echo >>"$TEMP"
    while read -r line
        echo "$line"
    end <"$TEMP"
end

function create_folder_file
    if test (count $argv) -lt 1
        echo "Error: Argument missing, please enter the filename with fullpath."
        return
    end

    for file_path_info in $argv
        mkdir -p (dirname -- $file_path_info)
        touch -- $file_path_info
    end
end
