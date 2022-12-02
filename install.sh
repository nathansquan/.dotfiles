# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.antibody \
	nixpkgs.git \
	nixpkgs.neovim \
	nixpkgs.emacs-nox \
	nixpkgs.tmux \
	nixpkgs.stow \
	nixpkgs.direnv

# stow
stow git
stow zsh
stow nvim
stow tmux

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# assign zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
