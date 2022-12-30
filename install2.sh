# install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.antibody \
	nixpkgs.git \
	nixpkgs.emacs-nox \
	nixpkgs.tmux \
	nixpkgs.stow \
	nixpkgs.direnv \
    nixpkgs.dotnet-sdk \
    nixpkgs.clojure \
    nixpkgs.nodejs \
    nixpkgs.mitscheme \
    nixpkgs.julia

# stow
stow git
stow zsh
stow nvim
stow tmux

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# install package required to use chsh in Fedora
sudo dnf install util-linux-user

# assign zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
