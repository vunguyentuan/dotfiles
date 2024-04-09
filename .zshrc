eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(brew shellenv)"

setopt INC_APPEND_HISTORY        # Add commands to HISTFILE in order of execution
setopt SHARE_HISTORY             # Share command history data
setopt EXTENDED_HISTORY          # Save timestamp and duration information

export EDITOR="nvim" # or "vim", or "code", etc.

export GPG_TTY=$(tty)

export NNN_OPENER="nnn-hx.sh"
export FZF_TMUX_OPTS="-p 55%,60%"

export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore"

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

if [[ $(uname) == "Darwin" ]]; then
  alias gaws="~/projects/govtech/ctsg-infra-ops/ops/ctsg_remote_access.sh -u vu_nguyen -e dev -a power"
  alias cdbdev="~/projects/govtech/ctsg-infra-ops/ops/ctsg_remote_access.sh -u vu_nguyen -e dev -a power -d"
  alias config='/opt/homebrew/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
else
  alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

if [[ $(uname) == "Darwin" ]]; then
  export PATH="$(brew --prefix python)/libexec/bin:$PATH"
  export PATH="/Applications/MAMP/bin/php/php8.2.0/bin:$PATH"
  export PATH="/Applications/MAMP/bin/php:$PATH"
  export PATH="$HOME/Library/Python/3.11/bin:$PATH"
  export PNPM_HOME=$HOME/Library/pnpm
  export PATH="$PNPM_HOME:$PATH"
fi



export PATH="$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH"

create_folder_file() {
    if [[ $# -lt 1 ]]; then
        echo "Error: Argument missing, please enter the filename with fullpath."
        return
    fi

    for file_path_info in "$@"; do
        mkdir -p $(dirname -- $file_path_info)
        touch -- $file_path_info
    done
}


autoload -U promptinit && promptinit

# Color settings
autoload -U colors && colors
export LSCOLORS="Exfxcxdxbxegedabagacad"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
