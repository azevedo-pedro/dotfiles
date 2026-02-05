#!/bin/sh

source colors.sh

#  Brew Cask ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
msg_install "Installing apps with brew cask"

cask=(
  "arc"
  "figma"
  "font-fira-code-nerd-font"
  "ghostty"
  "google-chrome"
  "obsidian"
  "orbstack"
  "raycast"
  "telegram"
  "visual-studio-code"
  "whatsapp"
  "yaak"
)

for app in "${cask[@]}"; do
  msg_install "Installing $app"
  brew install --cask $app
  msg_ok "$app installed"
done
