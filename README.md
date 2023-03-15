# Linux Configuration

## Prequisitions

- Install git for loading plugins `sudo apt install git;`
- Run `ssh-keygen -t ed25519 -C "your_email@example.com"`
- Run `eval "$(ssh-agent -s)"`
- Run `ssh-add ~/.ssh/id_ed25519`
- Add the key to your github account through the settings

## Get started

- Clone this repository into your root directory
- Run `source ~/.bashrc`
- Enjoy your minimal upgrade with aliases

## Unleash zsh

- Run `sudo apt install zsh;`
- Install curl in order to install oh-my-zsh `sudo apt install curl;`
- Install oh-my-zsh and follow the instructions `sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";`
- Install Starship prompt `curl -fsSL https://starship.rs/install.sh | sh`

## Load additional plugins

- Run `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-autosuggestions`
- Run `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
- Run `git clone https://github.com/wting/autojump.git  ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/autojump`
- Install Homebrew with the instructions found [here](https://brew.sh/)
- Run `brew install python3`
- Run `sudo apt install python-is-python3`
- Run `sudo pip3 install virtualenvwrapper`
- Go to the autojump plugin
- Run `./install.py`
- Run `pip install thefuck`
- Run `sudo apt-get install keychain`
