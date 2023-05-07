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
    run_cmd "sudo apt update && sudo apt full-upgrade"
    sudo apt update && sudo apt full-upgrade;
    run_cmd "sudo apt-get update && sudo apt-get upgrade -y"
    sudo apt-get update && sudo apt-get upgrade -y;
    cmd_success "✓ Updated local system"
}

function get_user_info() {
    cmd_describe "⧗ Getting informations ..."
    prompt_user What is your Windows User Name?
    read -p "➤ " windowsname
    winname="$windowsname"
    prompt_user What is your WSL User Name?
    read -p "➤ " wslname
    wname="$wslname"
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
    if [ ! -d ~/.ssh ]; then
        cmd_describe "SSH directory does not exist. Creating one ..."
        run_cmd "mkdir -p ~/.ssh"
        mkdir -p ~/.ssh;
    fi
    run_cmd "cp -r /mnt/c/Users/<username>/.ssh/* ~/.ssh/"
    cp -r /mnt/c/Users/${winname}/.ssh/* ~/.ssh/;
    run_cmd "cd ~/.ssh"
    if cd ~/.ssh; then
        cmd_success "Now in SSH directory."
    else
        cmd_error "Failed to change directory to SSH directory."
        return 1
    fi
    run_cmd "ssh-keygen -t ed25519 -b 4096 -C '${uemail}' -f '${uskname}'"
    ssh-keygen -t ed25519 -b 4096 -C "${uemail}" -f "${uskname}";
    run_cmd "eval $(ssh-agent -s)"
    eval "$(ssh-agent -s)";
    run_cmd "ssh-add ~/.ssh/${uskname}"
    ssh-add ~/.ssh/${uskname};
    run_cmd "chmod -R 600 ~/.ssh/*"
    chmod -R 600 ~/.ssh/*;
    run_cmd "cd ~/.dotfiles"
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

function write_wslconfig() {
    cmd_describe "⧗ Writing wsl conf ..."
    # Create a backup of existing wsl.conf file, if any
    sudo cp /etc/wsl.conf /etc/wsl.conf.bak

    run_cmd "sudo touch /etc/wsl.conf"
    sudo touch /etc/wsl.conf;

    # Write to /etc/wsl.conf with sudo
    sudo sh -c "echo '[user]' >> /etc/wsl.conf"
    sudo sh -c "echo 'default=${wname}' >> /etc/wsl.conf"

    # Change file permissions to allow non-root users to read the file
    sudo chmod 644 /etc/wsl.conf

    # Change directory back to the dotfiles directory
    cd ~/.dotfiles
    cmd_success "✓ wsl conf written"
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

    run_cmd "Installing curl"
    sudo apt-get install curl -y;
    run_cmd "Installing git"
    sudo apt-get install git -y;

    run_cmd "Installing autojump"
    sudo apt-get install autojump -y;
    run_cmd "Installing stow"
    sudo apt-get install stow -y;
    run_cmd "Installing zsh"
    sudo apt-get install zsh -y;
    run_cmd "Installing fish"
    sudo apt-get install fish -y;

    run_cmd "Installing php"
    sudo apt-get install php -y;
    run_cmd "Installing php-mbstring"
    sudo apt-get install php-mbstring -y;
    run_cmd "Installing php-xml"
    sudo apt-get install php-xml -y;
    run_cmd "Installing php-zip"
    sudo apt-get install php-zip -y;
    run_cmd "Installing php-curl"
    sudo apt-get install php-curl -y;
    run_cmd "Installing php-xdebug"
    sudo apt-get install php-xdebug -y;
    run_cmd "sudo apt install php-cli unzip"
    sudo apt-get install php-cli unzip -y;
    
    run_cmd "sudo apt-get install bat"
    sudo apt-get install bat -y;
    
    run_cmd "sudo apt-get install fd-find"
    sudo apt-get install fd-find -y;

    run_cmd "Enable systemd"
    git clone https://github.com/DamionGans/ubuntu-wsl2-systemd-script.git;
    cd ubuntu-wsl2-systemd-script/;
    bash ubuntu-wsl2-systemd-script.sh;
    cd ~/.dotfiles;

    run_cmd "sudo apt install snapd"
    sudo apt install snapd -y;

    run_cmd "Enable snap service"
    sudo systemctl unmask snapd.service;
    sudo systemctl enable snapd.service;
    sudo systemctl start snapd.service;

    run_cmd "sudo snap install lsd"
    sudo snap install lsd;
    
    run_cmd "sudo apt-get install dos2unix"
    sudo apt-get install dos2unix -y;

    run_cmd "sudo apt-get install keychain"
    sudo apt-get install keychain -y;

    curl -sS https://starship.rs/install.sh | sh;
    
    cmd_success "✓ Installed dev tools"
}

function install_ddev() {
    cmd_describe "⧗ Installing docker ..."
    sudo apt install --no-install-recommends apt-transport-https ca-certificates curl gnupg2 -y;
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` test";
    sudo apt update;
    sudo apt install docker-ce docker-ce-cli containerd.io -y;
    sudo usermod -aG docker $USER;
    sudo apt-get update;
    sudo apt-get install docker-compose-plugin -y;
    docker --version;
    docker compose version;
    cmd_success "✓ Installed docker"

    cmd_describe "⧗ Installing ddev ..."
    run_cmd "curl -fsSL https://apt.fury.io/drud/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ddev.gpg > /dev/null"
    curl -fsSL https://apt.fury.io/drud/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ddev.gpg > /dev/null;
    run_cmd "echo "deb [signed-by=/etc/apt/trusted.gpg.d/ddev.gpg] https://apt.fury.io/drud/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list"
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/ddev.gpg] https://apt.fury.io/drud/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list;
    run_cmd "sudo apt update && sudo apt install -y ddev"
    sudo apt update;
    sudo apt install -y ddev;
    ddev;
    mkcert -install;
    cmd_success "✓ Installed ddev"
}

function install_composer() {
    cmd_describe "⧗ Installing composer ..."

    run_cmd "curl -sS https://getcomposer.org/installer -o ~/tmp/composer-setup.php"
    curl -sS https://getcomposer.org/installer -o ~/tmp/composer-setup.php;

    run_cmd "HASH=`curl sS https://composer.github.io/installer.sig`"
    HASH=`curl -sS https://composer.github.io/installer.sig`

    run_cmd "php -r 'if (hash_file(SHA384, ~/tmp/composer-setup.php') === $HASH) { echo Installer verified; } else { echo Installer corrupt; unlink(~/tmp/composer-setup.php); } echo PHP_EOL;'"
    php -r "if (hash_file('SHA384', '~/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('~/tmp/composer-setup.php'); } echo PHP_EOL;";

    run_cmd "sudo php ~/tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer"
    sudo php ~/tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer;

    cmd_success "✓ Installed composer"
    cmd_describe "⧗ Cleaning up"

    run_cmd "sudo apt autoremove -y"
    sudo apt autoremove -y;
    sudo apt-get autoremove -y;

    cmd_success "✓ Cleaned up"
}

function stow_files() {
    cmd_describe "⧗ Stowing dotfiles ..."
    dos2unix ~/.dotfiles/bash/.inputrc;
    run_cmd stow bash
    stow bash;
    run_cmd stow git
    rm ~/.gitconfig;
    stow git;
    run_cmd stow starship
    stow starship;
    run_cmd stow zsh
    stow zsh;
    run_cmd stow fish
    stow fish;
    cmd_success "✓ Stowed dotfiles"
}

function symlink_ddev_aliases() {
    cmd_describe "⧗ Symlinking bash configuration for ddev ..."
    cd ~/.ddev/; mkdir homeadditions;
    run_cmd "ln -s ~/.dotfiles/bash/.bash_aliases ~/.ddev/homeadditions/.bash_aliases"
    ln -s ~/.dotfiles/bash/.bash_aliases ~/.ddev/homeadditions/.bash_aliases;
    run_cmd "ln -s ~/.dotfiles/bash/.bashrc ~/.ddev/homeadditions/.bashrc"
    ln -s ~/.dotfiles/bash/.bashrc ~/.ddev/homeadditions/.bashrc;
    run_cmd  "ln -s /usr/local/bin/starship ~/.ddev/homeadditions/starship"
    ln -s /usr/local/bin/starship ~/.ddev/homeadditions/starship;
    run_cmd "ln -s ~/.dotfiles/starship/.config ~/.ddev/homeadditions/.config"
    ln -s ~/.dotfiles/starship/.config ~/.ddev/homeadditions/.config;

    cmd_success "✓ Symlinked bash_aliases"
}

function setup_zsh() {
    cmd_describe "⧗ Adding zsh as a login shell ..."
    run_cmd "command -v zsh | sudo tee -a /etc/shells"
    command -v zsh | sudo tee -a /etc/shells;

    cmd_success "✓ zsh is set up"
}

function bundle_zsh_plugins() {
    cmd_describe ⧗ Cloning zsh plugins ... 

    run_cmd "cd ~/.config"
    if [ ! -d ~/.config ]; then
        cmd_describe "config directory does not exist. Creating one ..."
        run_cmd "mkdir -p ~/.config"
        mkdir -p ~/.config;
    fi
    if cd ~/.config; then
        cmd_success "Now in config directory."
    else
        cmd_error "Failed to change directory to config directory."
        return 1
    fi
    run_cmd "git clone https://github.com/ohmyzsh/ohmyzsh.git"
    git clone https://github.com/ohmyzsh/ohmyzsh.git "oh-my-zsh";

    run_cmd "cd ~/.config/zsh/plugins"
    if [ ! -d ~/.config/zsh/plugins ]; then
        cmd_describe "config directory does not exist. Creating one ..."
        run_cmd "mkdir -p ~/.config/zsh/plugins"
        mkdir -p ~/.config/zsh/plugins;
    fi
    if cd ~/.config/zsh/plugins; then
        cmd_success "Now in .config/zsh/plugins directory."
    else
        cmd_error "Failed to change directory to .config/zsh/plugins directory."
        return 1
    fi

    run_cmd "git clone https://github.com/lukechilds/zsh-nvm.git"
    git clone "https://github.com/lukechilds/zsh-nvm.git" "zsh-nvm";

    run_cmd "git clone https://github.com/zsh-users/zsh-autosuggestions.git"
    git clone "https://github.com/zsh-users/zsh-autosuggestions.git" "zsh-autosuggestions";

    run_cmd "git clone https://github.com/zsh-users/zsh-completions.git"
    git clone "https://github.com/zsh-users/zsh-completions.git" "zsh-completions";

    run_cmd "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git"
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "zsh-syntax-highlighting";

    run_cmd "git clone https://github.com/zsh-users/zsh-history-substring-search.git"
    git clone "https://github.com/zsh-users/zsh-history-substring-search.git" "zsh-history-substring-search";

    run_cmd "git clone https://github.com/MichaelAquilina/zsh-you-should-use.git"
    git clone "https://github.com/MichaelAquilina/zsh-you-should-use.git" "zsh-you-should-use";

    run_cmd "cd ~/.dotfiles;"
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
    cd ~; 
    mkdir Documents Projects Media;
}

function fix_git_for_root() {
    chmod a+x ~/.dotfiles/git/git;
    sudo cp .ssh/iwmedien /root/.ssh/
    sudo cp .ssh/iwmedien.pub /root/.ssh/
    sudo cp .ssh/${uskname} /root/.ssh/
    sudo cp .ssh/${uskname}.pub /root/.ssh/
}

function print_pub_key() {
    cmd_describe "⧗ Printing public ssh key so you can add it to Bitbucket/GitHub ..."
    run_cmd "batcat ~/.ssh/${uskname}.pub"
    batcat ~/.ssh/${uskname}.pub;
    cd ~;
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
        write_wslconfig
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
        fix_git_for_root
        print_pub_key
        cmd_success "✓ Installation finished."
        run_cmd "Please set the git executable in phpstorm to \\\wsl$\\Work\\home\\${wname}\\git"
        run_cmd "Please exit wsl and restart it using wsl --shutdown"
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