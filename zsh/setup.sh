#!/usr/bin/env bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt user for installation
prompt_install() {
    read -p "Would you like to install $1? (y/n) " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Function to install package using dnf
install_package() {
    sudo dnf install -y "$1"
}

# Array of dependencies
dependencies=(
    "eza"
    "lsd"
    "bat"
    "ripgrep"
    "fd-find"
    "duf"
    "dust"
    "bottom"
    "zoxide"
    "fzf"
    "git"
)

# Check and prompt for installation of dependencies
for dep in "${dependencies[@]}"; do
    if ! command_exists "${dep%%:*}"; then
        echo "${dep%%:*} is not installed."
        if prompt_install "$dep"; then
            install_package "$dep" || echo "Failed to install $dep. Please install it manually."
        else
            echo "Skipping installation of $dep"
        fi
    fi
done

# Check and setup Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
    echo "Installing Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Check and setup NVM
if [[ ! -d "$HOME/.nvm" ]]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
fi

# Check and setup Pyenv
if ! command_exists pyenv; then
    echo "Installing Pyenv..."
    curl https://pyenv.run | bash
fi

echo "Setup complete. Please restart your shell or run 'source ~/.zshrc' to apply changes."
