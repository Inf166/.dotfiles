#!/bin/bash
color_red='\033[0;31m'
color_green='\033[0;32m'
color_blue='\033[0;34m'
color_orange='\033[0;33m'
no_color='\033[0m'

oops() {
    echo -e "${color_red}$0${no_color}" >&2
    exit 1
}

banner() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./#/g')
    msg="${color_green}# ${no_color}$* ${color_green}#"
    echo -e "${color_green}$edge"
    echo -e "$msg"
    echo -e "${color_green}$edge${no_color}"
}

warn() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./#/g')
    msg="${color_red}# ${no_color}$* ${color_red}#"
    echo -e "${color_red}$edge"
    echo -e "$msg"
    echo -e "${color_red}$edge${no_color}"
}

echo "force_color_prompt=yes" >> ~/.bashrc
source ~/.bashrc

banner PORTABLE DEVELOPMENT ENVIROMENT INSTALLER
echo ""
warn During this script we download and install some packages with sudo
echo ""

echo -e "${color_blue}Do you want to continue? (y/n)"
read confirmation
if $confirmation == "n"; then
    oops "No worries, you can do this later."
else

echo ""
banner Updating local system ...
echo -e "${color_orange}> sudo apt update && apt upgrade -y${no_color}"
sudo apt update && apt upgrade -y
echo -e "${color_orange}> sudo apt-get update && apt-get upgrade -y${no_color}"
sudo apt-get update && apt-get upgrade -y

echo ""
banner Creating new ssh key for you ...
echo Making ssh key dir
echo -e "${color_orange}> mkdir ~/.ssh${no_color}"
mkdir ~/.ssh

echo ""
echo -e "${color_blue}What should the ssh key be named?${no_color}"
read sshkeyname

echo ""
echo -e "${color_blue}What is you email address?${no_color}"
read email

echo ""
echo -e "${color_blue}What is your name for the git log?${no_color}"
read name

cd ~/.ssh

echo ""
banner Generating your ssh key ...
echo -e "${color_orange}> ssh-keygen -t ed25519 -b 4096 -C "${email}" -f "${sshkeyname}"${no_color}"
ssh-keygen -t ed25519 -b 4096 -C "${email}" -f "${sshkeyname}"

echo ""
banner Starting ssh agent ...
echo -e "${color_orange}> eval "$(ssh-agent -s)"${no_color}"
eval "$(ssh-agent -s)"

echo ""
banner Adding new ssh key ...
echo -e "${color_orange}> ssh-add ~/.ssh/${sshkeyname}${no_color}"
ssh-add ~/.ssh/${sshkeyname}

cd ~/.dotfiles

echo ""
banner Writing gitconfig

cd git/

echo "	name = ${name}" >> .gitconfig
echo "	email = ${email}" >> .gitconfig

cd ~/.dotfiles

echo ""
banner Backing up local files from WSL .bashrc, .profile ...
echo Move files to ~/.backups

echo ""
echo -e "${color_orange}> mkdir ~/.backups${no_color}"
mkdir ~/.backups

echo ""
echo -e "${color_orange}> mv ~/.bashrc ~/.backups/.bashrc${no_color}"
mv ~/.bashrc ~/.backups/.bashrc

echo ""
echo -e "${color_orange}> mv ~/.profile ~/.backups/.profile${no_color}"
mv ~/.profile ~/.backups/.profile

echo ""
banner Installing curl ...
sudo apt install curl -y

echo ""
banner Installing nix-package-manager ...
curl -L https://nixos.org/nix/install | sh

echo ""
banner Sourcing nix ...
. ~/.nix-profile/etc/profile.d/nix.sh

echo ""
banner Installing nix packages ...

nix-env -iA \
	nixpkgs.antibody \
	nixpkgs.autojump \
	nixpkgs.bat \
	nixpkgs.direnv \
	nixpkgs.git \
	nixpkgs.keychain \
	nixpkgs.starship \
	nixpkgs.stow \
	nixpkgs.zsh

echo ""
banner Installing ddev ...

curl -fsSL https://apt.fury.io/drud/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ddev.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/ddev.gpg] https://apt.fury.io/drud/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list
sudo apt update && sudo apt install -y ddev

echo ""
banner Stowing dotfiles ...
stow bash
stow git
stow starship
stow zsh

echo ""
banner Symlinking bash_aliases for ddev ...
ln -s ~/.dotfiles/bash/.bash_aliases ~/.ddev/homeadditions/.bash_aliases

echo ""
banner Adding zsh as a login shell ...
command -v zsh | sudo tee -a /etc/shells

echo ""
banner Using zsh as default shell ...
sudo chsh -s $(which zsh) $USER

echo ""
banner Bundling zsh plugins ... 
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

echo ""
banner Printing public ssh key so you can add it to Bitbucket/GitHub ...
bat ~/.ssh/${sshkeyname}.pub

echo ""
banner Press any key if you are done.
read anykey

echo ""
banner ALL DONE. You can close this tab now and open a new session.
fi