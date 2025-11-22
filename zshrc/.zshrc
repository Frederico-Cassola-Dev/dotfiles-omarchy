# ----------------------------------------------
# Initialize zsh completion system (needed for many plugins)
autoload -Uz compinit
compinit

# ----------------------------------------------
# Oh My Zsh Configuration

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Oh My Zsh theme (empty disables theme)
ZSH_THEME=""

# Enable plugins: git, syntax highlighting, autosuggestions
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions 
)

# Source Oh My Zsh core script (loads plugins and theme)
source $ZSH/oh-my-zsh.sh

# ----------------------------------------------
# External tool initializations

# Starship prompt initialization
eval "$(starship init zsh)"

# zoxide for smart directory jumping
eval "$(zoxide init zsh)"

# ----------------------------------------------
# Environment variables

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Uncomment and set PostgreSQL host if needed
# export PGHOST="/var/run/postgresql"

# ----------------------------------------------
# Shell history configuration

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000
# Enable incremental append history
setopt inc_append_history
# Enable void duplicate entries in history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
# Enable share history if multiple terminals concurrently
setopt share_history

# ----------------------------------------------
# CARAPACE shell completion framework configuration

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'  # enable support for multiple shells
zstyle ':completion:*' format '%{\e[2;37m%}Completing %d%{\e[m%}'
zstyle ':completion:*' format '%F{240}Completing %d%f' 
source <(carapace _carapace)

# ----------------------------------------------
# Trash-cli completions

# These completions should be installed once via a script, not every shell start:
# cmds=(trash-empty trash-list trash-restore trash-put trash)
# for cmd in ${cmds[@]}; do
#   $cmd --print-completion bash | sudo tee /usr/share/bash-completion/completions/$cmd
#   $cmd --print-completion zsh | sudo tee /usr/share/zsh/site-functions/_$cmd
#   $cmd --print-completion tcsh | sudo tee /etc/profile.d/$cmd.completion.csh
# done

# ----------------------------------------------
# Trash-cli command aliases for convenience
if command -v trash &> /dev/null; then
  alias tp='trash-put'      # move files to trash
  alias tl='trash-list'     # list trashed files
  alias tr='trash-restore'  # restore trashed files
  alias te='trash-empty'    # empty trash
fi

# ----------------------------------------------
# FZF- Bind fuzzy search key bindings (history and files)

if type fzf &>/dev/null; then
  alias fh='fc -rl 1 | fzf' # History
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'" # Files
fi

# ----------------------------------------------
# ZOXIDE- Alias zd -> cd
if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

# ----------------------------------------------
# LS- Alias using eza for colorful output with icons

if command -v eza &> /dev/null; then
  alias ls='eza -lha --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# ----------------------------------------------
# NEOVIM- Call neovim always in the current folder if no argument
#
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
