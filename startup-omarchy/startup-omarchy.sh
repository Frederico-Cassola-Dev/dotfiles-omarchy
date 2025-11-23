#!/usr/bin/env bash

# The above line make this file ececutable
#
# The file need to be call in the hyperland config file like this:
# exec-once = ~/startup.sh

# Wait for Hyprland to be ready
sleep 1

# Workspace 1: Terminal in ~/dotfiles
sleep 1 && hyprctl dispatch workspace 1
hyprctl dispatch exec "ghostty --working-directory=/home/cfcassola/dotfiles -e nvim"

# Workspace 2: Terminal (ghostty) in ~/work
sleep 1 && hyprctl dispatch workspace 2
hyprctl dispatch exec "ghostty --working-directory=/home/cfcassola/Work"

# Workspace 3: Google
sleep 1 && hyprctl dispatch workspace 3
hyprctl dispatch exec "chromium --new-window https://google.com"

# # Workspace 3: Terminal with Gemini
# sleep 1 && hyprctl dispatch workspace 3
# hyprctl dispatch exec "ghostty -e gemini"

# Workspace 1: Terminal in ~/notes
# sleep 1 && hyprctl dispatch workspace 1
# hyprctl dispatch exec "ghostty --working-directory=/home/cfcassola/notes -e nvim"

# Workspace 6: GitHub Repositories
# sleep 1 && hyprctl dispatch workspace 6
# hyprctl dispatch exec "chromium --new-window https://github.com/Frederico-Cassola-Dev?tab=repositories"

# Workspace 6: Perplexity
# sleep 1 && hyprctl dispatch workspace 6
# hyprctl dispatch exec "chromium --new-window --app=https://www.perplexity.ai/"

# Workspace 8: YouTube
# sleep 1 && hyprctl dispatch workspace 8
# hyprctl dispatch exec "chromium --new-window --app=https://youtube.com"

# Return to the Workspace 2
sleep 2 && hyprctl dispatch workspace 2
