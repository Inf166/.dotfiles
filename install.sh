#!/bin/bash
oops() {
    echo "$0:" "$@" >&2
    exit 1
}

banner() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./#/g')
    echo "$edge"
    echo "$msg"
    echo "$edge"
}

echo ------------------------------------------------------------------
echo WELCOME TO THE PORTABLE DEVELOPMENT ENVIROMENT INSTALL SCRIPT
echo ""
echo During this script we download and install some packages with sudo
echo ""
echo ------------------------------------------------------------------

echo "Do you want to continue? (y/n)"
read confirmation
if $confirmation == "n"; then
    oops "No worries, you can do this later."
else
echo ------------------------------------------------------------------
echo First, we need to update your system.
echo "sudo apt update && apt upgrade -y"
# Update and Upgrade local packages (assume yes)
sudo apt update && apt upgrade -y
echo "sudo apt-get update && apt-get upgrade -y"
sudo apt-get update && apt-get upgrade -y

echo ------------------------------------------------------------------
echo Creating new ssh key for you
echo What should the ssh key be named?
read sshkeyname
echo What is you email address?
read email
ssh-keygen -t ${sshkeyname} -C "${email}"

echo Starting ssh agent
eval "$(ssh-agent -s)"

echo Adding new ssh key
ssh-add ~/.ssh/${sshkeyname}

echo ------------------------------------------------------------------
echo Backup local files from WSL .bashrc, .profile
echo Move files to ~/.backups
mkdir ~/.backups
mv ~/.bashrc ~/.backups/.bashrc
mv ~/.profile ~/.backups/.profile

echo ------------------------------------------------------------------
echo Install curl
sudo apt install curl -y

echo ------------------------------------------------------------------
echo Install nix-package-manager
curl -L https://nixos.org/nix/install | sh

echo ------------------------------------------------------------------
echo Source nix
. ~/.nix-profile/etc/profile.d/nix.sh

echo ------------------------------------------------------------------
echo Install nix packages
nix-env -iA \
	nixpkgs.antibody \
	nixpkgs.autojump \
	nixpkgs.bat \
	nixpkgs.direnv \
	nixpkgs.docker \
	nixpkgs.gcc \
	nixpkgs.git \
	nixpkgs.keychain \
	nixpkgs.starship \
	nixpkgs.stow \
	nixpkgs.zsh

echo ------------------------------------------------------------------
echo Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo ------------------------------------------------------------------
echo Install ddev
curl -fsSL https://ddev.com/install.sh | bash

echo ------------------------------------------------------------------
echo Stow dotfiles
stow bash
stow git
stow starship
stow zsh

echo ------------------------------------------------------------------
echo Add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

echo ------------------------------------------------------------------
echo Use zsh as default shell
sudo chsh -s $(which zsh) $USER

echo ------------------------------------------------------------------
echo Bundle zsh plugins 
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

echo ------------------------------------------------------------------
echo Printing public ssh key so you can add it to Bitbucket/GitHub
bat ~/.ssh/${sshkeyname}_pub

echo \n
echo \n
echo Press any key if you are done.
read anykey

echo ------------------------------------------------------------------
echo ALL DONE. You can close this tab now and open a new session.
echo ------------------------------------------------------------------
fi