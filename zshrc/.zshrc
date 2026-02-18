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
# Aliases ls / eza
#############################################

if command -v eza &> /dev/null; then
  alias ls='eza -lha --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi


#############################################
# Aliases Stack JAM
#############################################
alias manage='manage-stack.sh'

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

#############################################
# Open a new terminal and open TMUX into the last session or tmuxa
#############################################

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    session_count=$(tmux list-sessions 2>/dev/null | wc -l)
    if [ "$session_count" -eq 0 ]; then
        tmux  # Continuum restores
    elif [ "$session_count" -eq 1 ]; then
        tmux attach  # Auto-attach single session
    else
        tmuxa  # Fzf picker for multiple
    fi
fi

#############################################
# Atuin search history
#############################################

[[ -f ~/.atuin/bin/env ]] && . "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="$HOME/.local/bin:$PATH"

############################################
# Aliases from .bashrc
############################################

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

############################################
# SSH Agent: Auto-start + load keys if empty
############################################

if [[ -f ~/.ssh/id_ed25519_github ]] || [[ -f ~/.ssh/id_ed25519_gitlab ]]; then
    if [ -z "$SSH_AUTH_SOCK" ] || ! ssh-add -l >/dev/null 2>&1; then
        eval "$(ssh-agent -s)"
        [[ -f ~/.ssh/id_ed25519_github ]] && ssh-add ~/.ssh/id_ed25519_github
        [[ -f ~/.ssh/id_ed25519_gitlab ]] && ssh-add ~/.ssh/id_ed25519_gitlab
    fi
fi

############################################
# Git ultra-rapide sur /mnt/c (Windows filesystem)
############################################
function git() {
  if [[ "$(pwd)" == /mnt/c/* ]]; then
    /mnt/c/Windows/System32/cmd.exe /c "git.exe $@"
  else
    command git "$@"
  fi
}

############################################
# cht.sh Cheat Sheet
############################################

# Need to add this to have zsh autocomplete for cht.sh
# mkdir -p ~/.zsh.d
# curl https://cheat.sh/:zsh > ~/.zsh.d/_cht
# Load the plugin cht.sh
[[ -d ~/.zsh.d ]] && fpath=(~/.zsh.d $fpath)
alias cheat='cht.sh'
