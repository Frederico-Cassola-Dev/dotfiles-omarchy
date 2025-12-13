#############################################
# Core zsh & completion
#############################################

autoload -Uz compinit
compinit

#############################################
# Oh My Zsh
#############################################

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source "$ZSH/oh-my-zsh.sh"

#############################################
# Prompt & navigation tools
#############################################

# Starship prompt
eval "$(starship init zsh)"

# zoxide: smarter cd
eval "$(zoxide init zsh)"

#############################################
# Editor & environment
#############################################

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
# export PGHOST="/var/run/postgresql"

#############################################
# History
#############################################

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt share_history

#############################################
# Carapace + Catppuccin
#############################################

# Catppuccin Mocha LS_COLORS (requires: pacman -S vivid)
if command -v vivid &> /dev/null; then
  export LS_COLORS="$(vivid generate catppuccin-mocha)"
fi

# Let Carapace reuse other completion specs when needed
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'

# Subtle “Completing …” header color
zstyle ':completion:*' format '%F{240}Completing %d%f'

# Carapace + Catppuccin look for completion menus
carapace --style 'carapace.Value=bold,bright-cyan'
carapace --style 'carapace.Description=dim,bright-black'

# Initialize Carapace completions
source <(carapace _carapace)

#############################################
# Trash-cli
#############################################

# One-time completion install (keep commented for reference)
# cmds=(trash-empty trash-list trash-restore trash-put trash)
# for cmd in "${cmds[@]}"; do
#   $cmd --print-completion bash | sudo tee /usr/share/bash-completion/completions/$cmd
#   $cmd --print-completion zsh  | sudo tee /usr/share/zsh/site-functions/_$cmd
#   $cmd --print-completion tcsh | sudo tee /etc/profile.d/$cmd.completion.csh
# done

if command -v trash &> /dev/null; then
  alias tp='trash-put'
  alias tl='trash-list'
  alias tr='trash-restore'
  alias te='trash-empty'
fi

#############################################
# FZF helpers
#############################################

if command -v fzf &> /dev/null; then
  alias fh='fc -rl 1 | fzf'  # history
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi

# Open file or directory in Neovim using fd + fzf
nf() {
  local selection
  selection=$(
    fd --type f --type d \
      | fzf --preview '[[ -f {} ]] && bat --style=numbers --color=always {} || echo {} is a directory' \
             --preview-window=right:60%
  )
  if [ -n "$selection" ]; then
    nvim "$selection"
  fi
}

#############################################
# Zoxide: cd replacement
#############################################

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

#############################################
# ls / eza aliases
#############################################

if command -v eza &> /dev/null; then
  alias ls='eza -lha --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

#############################################
# Neovim helper
#############################################

n() {
  if [ "$#" -eq 0 ]; then
    nvim .
  else
    nvim "$@"
  fi
}


#############################################
# Tmux attach session at before start tmux
#############################################

tmuxa() {
  session=$(
    tmux list-sessions -F '#S' 2>/dev/null |
      fzf --height=60% \
          --layout=reverse-list \
          --border=rounded \
          --margin=20%,30% \
          --prompt='tmux> '
  ) || return 1

  tmux attach -t "$session"
}

