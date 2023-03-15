#   ___  _  _     __  ____   __  _______ _  _
#  / _ \| || |___|  \/  \ \ / /_|_  / __| || |
# | (_) | __ |___| |\/| |\ V /___/ /\__ \ __ |
#  \___/|_||_|   |_|  |_| |_|   /___|___/_||_|

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.extensions/.oh-my-zsh"

# Path to custom plugins, themes and config
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"

# Set the theme
# ZSH_THEME="example"

# Load plugins
plugins=(
		alias-finder
		autojump
		git
		keychain
		npm
		pip
		python
		ssh-agent
		thefuck
		virtualenv
		web-search
		zsh-autosuggestions
		zsh-syntax-highlighting
)

# Init function for oh-my-zsh
# Also sources all custom .zsh in $ZSH_CUSTOM/ alphabetically
source $ZSH/oh-my-zsh.sh
