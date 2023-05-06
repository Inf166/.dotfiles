#  _______ _  _
# |_  / __| || |
#  / /\__ \ __ |
# /___|___/_||_|

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$HOME/.config/zsh"

# Bash history
HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git keychain autojump git git-extras node npm ssh-agent web-search zsh-nvm zsh-syntax-highlighting zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-you-should-use)

source $ZSH/oh-my-zsh.sh
# Define config path of starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export STARSHIP_CACHE=$HOME/.config/starship/cache

# Init Starship
eval $(starship init zsh)
