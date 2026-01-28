#!/bin/sh

source colors.sh

#  Brew Cask ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
msg_install "Installing apps with brew cask"

cask=(
  "cursor"
  "ghostty"
  "google-chrome"
  "handbrake"
  "raycast"
  "imageOptim"
  "yaak"
)

for app in "${cask[@]}"; do
  msg_install "Installing $app"
  brew install --cask $app
  msg_ok "$app installed"
done
