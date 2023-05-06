#!/bin/bash

# COLORS

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[1;35m'
ORANGE='\033[0;33m'
NO_COLOR='\033[0m'

ERROR=${RED}
SUCCESS=${GREEN}
PROMPT=${BLUE}
PREVIEW=${ORANGE}
DESCRIPTION=${PURPLE}
NC=${NO_COLOR}

# FANCY PROMPTS

function prompt_user() {
    msg="$*"
    line=$(echo "$msg" | sed 's/./─/g')
    topedge="${PROMPT}┌─$line─┐${NC}"
    botedge="${PROMPT}└─$line─┘${NC}"
    msg="${PROMPT}│${NC} $* ${PROMPT}│${NC}"
    echo -e "$topedge"
    echo -e "$msg"
    echo -e "$botedge"
    echo ""
}

function cmd_success() {
    msg="$*"
    line=$(echo "$msg" | sed 's/./─/g')
    topedge="${SUCCESS}┌─$line─┐${NC}"
    botedge="${SUCCESS}└─$line─┘${NC}"
    msg="${SUCCESS}│${NC} $* ${SUCCESS}│${NC}"
    echo -e "$topedge"
    echo -e "$msg"
    echo -e "$botedge"
    echo ""
}

function cmd_error() {
    msg="$*"
    line=$(echo "$msg" | sed 's/./─/g')
    topedge="${ERROR}┌─$line─┐${NC}"
    botedge="${ERROR}└─$line─┘${NC}"
    msg="${ERROR}│${NC} $* ${ERROR}│${NC}"
    echo -e "$topedge"
    echo -e "$msg"
    echo -e "$botedge"
    echo ""
}

function cmd_describe() {
    msg="$*"
    line=$(echo "$msg" | sed 's/./─/g')
    topedge="${PRUPLE}┌─$line─┐${NC}"
    botedge="${PRUPLE}└─$line─┘${NC}"
    msg="${PRUPLE}│${NC} $* ${PRUPLE}│${NC}"
    echo -e "$topedge"
    echo -e "$msg"
    echo -e "$botedge"
    echo ""
}

function run_cmd() {
    msg="${PREVIEW}» $*${NC}"
    echo -e "$msg"
}

# Sections of the Script

function update_system() {
    cmd_describe "⧗ Updating local system ..."
    run_cmd "sudo apt update && apt upgrade -y"
    sudo apt update && sudo apt full-upgrade
    run_cmd "sudo apt-get update && apt-get upgrade -y"
    sudo apt-get update && sudo apt-get upgrade -y
    cmd_success "✓ Updated local system"
}

function get_user_info() {
    cmd_describe "⧗ Getting informations ..."
    prompt_user What should the ssh key be named?
    read -p "➤ " sshkeyname
    uskname="$sshkeyname"
    prompt_user What is you email address?
    read -p "➤ " email
    uemail="$email"
    prompt_user What is your name for the git log?
    read -p "➤ " name
    uname="$name"
    cmd_success "✓ Thank you!"
}

function generate_ssh_key() {
    cmd_describe "⧗ Creating new ssh key for you ..."
    run_cmd mkdir ~/.ssh
    mkdir ~/.ssh;
    run_cmd cd ~/.ssh
    cd ~/.ssh;
    run_cmd "ssh-keygen -t ed25519 -b 4096 -C "${uemail}" -f "${uskname}
    ssh-keygen -t ed25519 -b 4096 -C "${uemail}" -f "${uskname}";
    run_cmd "eval ssh-agent -s"
    eval "$(ssh-agent -s)";
    run_cmd "ssh-add ~/.ssh/"${uskname}
    ssh-add ~/.ssh/${uskname};
    run_cmd cd ~/.dotfiles
    cd ~/.dotfiles;
    cmd_success "✓ Generated ssh key"
}

function write_gitconfig() {
    cmd_describe "⧗ Writing gitconfig ..."
    run_cmd cd ~/.dotfiles/git/
    cd ~/.dotfiles/git/;
    run_cmd "echo '	name = ${name}' >> .gitconfig"
    echo "	name = ${name}" >> .gitconfig;
    run_cmd "echo '	email = ${email}' >> .gitconfig"
    echo "	email = ${email}" >> .gitconfig;
    run_cmd cd ~/.dotfiles
    cd ~/.dotfiles;
    cmd_success "✓ Gitconfig written"
}

function backup_bashfiles() {
    cmd_describe "⧗ Backing up local files from WSL .bashrc, .profile ..."
    run_cmd mkdir ~/.backups
    mkdir ~/.backups;
    run_cmd mv ~/.bashrc ~/.backups/.bashrc
    mv ~/.bashrc ~/.backups/.bashrc;
    run_cmd mv ~/.profile ~/.backups/.profile
    mv ~/.profile ~/.backups/.profile;
    cmd_success "✓ Backup complete"
}

function install_curl() {
    cmd_describe "⧗ Installing curl ..."
    run_cmd "sudo apt install curl -y"
    sudo apt install curl -y;
    cmd_success "✓ Installed curl"
}

function install_dependencies() {
    cmd_describe "⧗ Installing dev tools ..."
    sudo apt-get install -y autojump git stow zsh fish;
    sudo apt install bat;
    sudo apt install fd-find;
    sudo apt install exa;
    sudo apt install duf;
    curl -sS https://starship.rs/install.sh | sh;
    cmd_success "✓ Installed dev tools"
}

function install_ddev() {
    cmd_describe "⧗ Installing ddev ..."
    run_cmd "sudo apt install curl -y"
    run_cmd "curl -fsSL https://apt.fury.io/drud/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ddev.gpg > /dev/null"
    curl -fsSL https://apt.fury.io/drud/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ddev.gpg > /dev/null
    run_cmd "echo "deb [signed-by=/etc/apt/trusted.gpg.d/ddev.gpg] https://apt.fury.io/drud/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list"
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/ddev.gpg] https://apt.fury.io/drud/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list
    run_cmd "sudo apt update && sudo apt install -y ddev"
    sudo apt update && sudo apt install -y ddev
    ddev
    cmd_success "✓ Installed ddev"
}

function install_composer() {
    cmd_describe "⧗ Installing php-cli ..."
    
    run_cmd "sudo apt install php-cli unzip"
    sudo apt install php-cli unzip

    cmd_success "✓ Installed php-cli"
    cmd_describe "⧗ Installing composer ..."

    run_cmd "curl -sS https://getcomposer.org/installer -o ~/tmp/composer-setup.php"
    curl -sS https://getcomposer.org/installer -o ~/tmp/composer-setup.php

    run_cmd "HASH=`curl sS https://composer.github.io/installer.sig`"
    HASH=`curl -sS https://composer.github.io/installer.sig`

    run_cmd "php -r 'if (hash_file(SHA384, ~/tmp/composer-setup.php') === $HASH) { echo Installer verified; } else { echo Installer corrupt; unlink(~/tmp/composer-setup.php); } echo PHP_EOL;'"
    php -r "if (hash_file('SHA384', '~/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('~/tmp/composer-setup.php'); } echo PHP_EOL;"

    run_cmd "sudo php ~/tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer"
    sudo php ~/tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

    cmd_success "✓ Installed composer"
}

function stow_files() {
    cmd_describe "⧗ Stowing dotfiles ..."
    run_cmd stow bash
    stow bash
    run_cmd stow git
    stow git
    run_cmd stow starship
    stow starship
    run_cmd stow zsh
    stow zsh
    run_cmd stow fish
    stow fish
    cmd_success "✓ Stowed dotfiles"
}

function symlink_ddev_aliases() {
    cmd_describe "⧗ Symlinking bash configuration for ddev ..."
    cd ~/.ddev/; mkdir homeadditions;
    run_cmd "ln -s ~/.dotfiles/bash/.bash_aliases ~/.ddev/homeadditions/.bash_aliases"
    ln -s ~/.dotfiles/bash/.bash_aliases ~/.ddev/homeadditions/.bash_aliases
    run_cmd "ln -s ~/.dotfiles/bash/.bashrc ~/.ddev/homeadditions/.bashrc"
    ln -s ~/.dotfiles/bash/.bashrc ~/.ddev/homeadditions/.bashrc
    run_cmd  "ln -s /usr/local/bin/starship ~/.ddev/homeadditions/starship"
    ln -s /usr/local/bin/starship ~/.ddev/homeadditions/starship
    run_cmd "ln -s ~/.dotfiles/starship/.config ~/.ddev/homeadditions/.config"
    ln -s ~/.dotfiles/starship/.config ~/.ddev/homeadditions/.config

    cmd_success "✓ Symlinked bash_aliases"
}

function setup_zsh() {
    cmd_describe "⧗ Adding zsh as a login shell ..."
    run_cmd "command -v zsh | sudo tee -a /etc/shells"
    command -v zsh | sudo tee -a /etc/shells

    cmd_describe ⧗ Using zsh as default shell ...
    run_cmd "sudo chsh -s which zsh USER"
    sudo chsh -s $(which zsh) $USER

    cmd_success "✓ zsh is set up"
}

function bundle_zsh_plugins() {
    cmd_describe ⧗ Cloning zsh plugins ... 
    cd ~/.config; 
    git clone https://github.com/ohmyzsh/ohmyzsh.git "oh-my-zsh";
    git clone "https://github.com/lukechilds/zsh-nvm.git" "zsh-nvm";
    git clone "https://github.com/zsh-users/zsh-autosuggestions.git" "zsh-autosuggestions";
    git clone "https://github.com/zsh-users/zsh-completions.git" "zsh-completions";
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "zsh-syntax-highlighting";
    git clone "https://github.com/zsh-users/zsh-history-substring-search.git" "zsh-history-substring-search";
    git clone "https://github.com/MichaelAquilina/zsh-you-should-use.git" "zsh-you-should-use";
    cd ~/.dotfiles;
    cmd_success "✓ zsh plugins cloned"
}

function build_lazy_vim() {
  # cd ~ && git clone https://github.com/LuaJIT/LuaJIT.git;
  # cd LuaJIT && make;
  # sudo make install;
  # sudo ln -sf luajit-2.1.0-beta3 /usr/local/bin/luajit;
  cd ~;
  sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl;
  sudo apt install -y luajit;
  git clone https://github.com/neovim/neovim.git;
  cd neovim && make CMAKE_BUILD_TYPE=Release && sudo make install;

  # required
  mv ~/.config/nvim ~/.config/nvim.bak;
  # optional but recommended
  mv ~/.local/share/nvim ~/.local/share/nvim.bak;
  mv ~/.local/state/nvim ~/.local/state/nvim.bak;
  mv ~/.cache/nvim ~/.cache/nvim.bak;
  git clone https://github.com/LazyVim/starter ~/.config/nvim;
  rm -rf ~/.config/nvim/.git;
}

function create_working_dirs() {
    cmd_describe "⧗ Creating some default working dirs..."
    run_cmd "mkdir Documents Projects Media"
    cd ~; mkdir Documents Projects Media;
}

function print_pub_key() {
    cmd_describe "⧗ Printing public ssh key so you can add it to Bitbucket/GitHub ..."
    run_cmd "bat ~/.ssh/${uskname}.pub"
    bat ~/.ssh/${uskname}.pub
}

# Starting the Script

cmd_success "PORTABLE DEVELOPMENT ENVIROMENT INSTALLER"

cmd_error "During this script we download and install some packages with sudo"

prompt_user "What do you want to do?"

PS3="➤ "

options=("Full installation" "Generate new ssh-key" "Bundle zsh-plugins" "Setup gitconfig" "Symlink ddev" "Quit")
show_options=true

while $show_options; do
  select opt in "${options[@]}"; do
    case $opt in
      "Full installation")
        clear
        echo "force_color_prompt=yes" >> ~/.bashrc
        source ~/.bashrc
        update_system
        get_user_info
        generate_ssh_key
        write_gitconfig
        backup_bashfiles
        install_curl
        install_dependencies
        install_ddev
        install_composer
        stow_files
        symlink_ddev_aliases
        setup_zsh
        bundle_zsh_plugins
        create_working_dirs
        print_pub_key
        cmd_success "✓ Installation finished."
        show_options=false
        break
        ;;
      "Generate new ssh-key")
        clear
        get_user_info
        generate_ssh_key
        print_pub_key
        break
        ;;
      "Bundle zsh-plugins")
        clear
        bundle_zsh_plugins
        break
        ;;
      "Setup gitconfig")
        clear
        get_user_info
        write_gitconfig
        break
        ;;
      "Symlink ddev")
        clear
        symlink_ddev_aliases
        break
        ;;
      "Quit")
        cmd_error "Leaving Script ..."
        show_options=false
        break
        ;;
      *) 
        clear
        echo -e "${ERROR}✗ Invalid option:${NC}" $REPLY
        break
        ;;
    esac
  done
done