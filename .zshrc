# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::brew
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias c='clear'
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

# Locale
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

export EDITOR="nvim" # or "vim", or "code", etc.
export AWS_PROFILE="ctsg"

export GPG_TTY=$(tty)
export NNN_OPENER="nnn-hx.sh"
export FZF_TMUX_OPTS="-p 55%,60%"
export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export BUN_INSTALL="$HOME/.bun"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

function gaws () {
  ~/Projects/Govtech/ctsg-infra-ops/ops/ctsg_remote_access.sh -u vu.nguyen2 -e dev -a power
}

function cdbdev(){
  ~/Projects/Govtech/ctsg-infra-ops/ops/ctsg_remote_access.sh -u vu.nguyen2 -e dev -a power -d -dbp 10003
}
function cdbstg(){
  ~/Projects/Govtech/ctsg-infra-ops/ops/ctsg_remote_access.sh -u vu.nguyen2 -e stg -a power -d -dbp 10004
}

if [[ $(uname) == "Darwin" ]]; then
  export PATH="$(brew --prefix python)/libexec/bin:$PATH"
  export PATH="$HOME/Library/Python/3.11/bin:$PATH"
  export PNPM_HOME=$HOME/Library/pnpm
  export PATH="$PNPM_HOME:$PATH"
fi

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

### End of Zinit's installer chunk
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
