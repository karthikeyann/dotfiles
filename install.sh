#!/bin/bash -eu
if [ ! -e ~/.local/bin/chezmoi ]; then
	sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
fi
#bash -c "chezmoi init --apply https://github.com/karthikeyann/dotfiles.git"
bash -c "chezmoi init --apply karthikeyann --force"
echo "Installed dotfiles"

if [ -e ~/.local/bin/nvim ]; then
	echo "Already nvim installed"
else
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz --output-dir /tmp
	tar -C ~/.local/ -xzf /tmp/nvim-linux64.tar.gz --strip-components=1
	echo "Installed nvim"
fi

# Above the fold
######################################################################################################################
# below the fold

