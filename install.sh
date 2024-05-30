#!/bin/bash -eu
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
#bash -c "chezmoi init --apply https://github.com/karthikeyann/dotfiles.git"
bash -c "chezmoi init --apply karthikeyann --force"
echo "Installed dotfiles"

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz --output-dir /tmp
tar -C ~/.local/ -xzf /tmp/nvim-linux64.tar.gz --strip-components=1
echo "Installed nvim"

# Above the fold
######################################################################################################################
# below the fold

