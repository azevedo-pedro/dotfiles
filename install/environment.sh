#!/bin/sh

source colors.sh

# Brew
msg_install "Setting up Homebrew"
if test ! $(which brew); then
  msg_install "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  msg_ok 'Homebrew installed'
  exec "$SHELL"
else
  msg_alert "Homebrew already installed"
fi

msg_update "Updating Homebrew"
brew update
brew upgrade

# Brew apps
msg_install "Installing command line tools with brew"
brew cleanup
brew tap buo/cask-upgrade

tools=(
  "bat"
  "curl"
  "eza"
  "fzf"
  "gh"
  "git"
  "jq"
  "mise"
  "neovim"
  "pnpm"
  "starship"
  "tree"
  "uv"
  "wget"
  "zoxide"
  "zsh"
  "zsh-syntax-highlighting"
  "zsh-autosuggestions"
  "zsh-completions"
  "zsh-history-substring-search"
)

for tool in "${tools[@]}"; do
  if brew list "$tool" &>/dev/null; then
    msg_info "$tool already installed"
  else
    msg_install_item "Installing $tool"
    brew install "$tool"
    msg_ok "$tool installed"
  fi
done

msg_ok "Apps installed"

# oh-my-zsh
if (test ! -d $HOME/.oh-my-zsh); then
  msg_install "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  msg_ok "oh-my-zsh installed"
else
  msg_alert "oh-my-zsh already installed"
fi

# oh-my-zsh plugins
if (test ! -d $HOME/.oh-my-zsh); then
  msg_install "Installing oh-my-zsh plugins"

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  msg_ok "oh-my-zsh installed with plugins"
else
  msg_alert "oh-my-zsh already installed with plugins"
fi

# Node.js with mise
if ! mise which node &> /dev/null; then
   echo "Installing Node.js via mise"
   mise use --global node@lts
   mise install node
else
  msg_alert "Node.js already installed"
fi
