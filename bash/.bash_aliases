### Functions for aliases ###
nvmv() {
	nvm --version | awk '{print "nvm version " $1}';
}

npmv() {
	npm --version | awk '{print "npm version " $1}';
}

# My aliases

# zsh
alias edit='vim ~/.zshrc'
alias src='source ~/.zshrc'

# Bundle zsh plugins via antibody
alias update-antibody='antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.sh'

# cat -> bat
alias cat='bat'

# system
alias sagi='sudo apt-get install'
alias sagu='sudo apt-get update && sudo apt-get upgrade'
alias sai='sudo apt install'
alias sau='sudo apt update && sudo apt upgrade'

# navigation
alias ..='cd ..'
alias ...='cd ../..'

# list
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -alF'
alias stats='nvmv; npmv; git --version; ddev --version; docker --version; docker-compose --version;'
alias ddevstats="ddev . npm --version | awk '{print "npm version " $1}'; ddev . node --version | awk '{print "node version " $1}';  ddev . php -v | grep PHP | awk '{print "php version " $2}'| head -1; ddev . composer --version | grep version | awk '{print "composer version " $3}'"

# dangerzone
alias mv='mv -i'
alias rm='rm -i'

# git
alias gs='git status'
alias gd='git diff'
alias glog='git log --graph --pretty=oneline --abbrev-commit'
alias gaa='git add .'
alias push='git push origin'

# Docker
alias ds='docker ps'

# DDev
alias dstart="ddev start"
alias dstop="ddev stop"
alias poweroff="ddev poweroff"
alias snapshot="ddev snapshot --name $(date +%Y-%m-%d_%H-%M)-${PWD##*/}"

# DDev launch windows
alias describe="ddev describe"
alias launch="ddev launch"
alias mail="ddev launch -m"
alias db="ddev launch -p"
alias fe="ddev launch"
alias be="ddev launch /typo3"
alias itool="ddev launch /typo3/install.php"

# DDev TYPO3
alias cache="ddev typo3cms cache:flush;"
alias ccache="ddev composer du;"
alias fullcache="cache; ccache;"
alias dbupdate="ddev typo3cms database:updateschema;"
alias fixfolder="ddev typo3cms install:fixfolderstructure;"
alias cadmin="ddev typo3cms backend:createadmin"

# DDev Node Js
alias npmi="ddev . npm i"
alias build="ddev . npm run typo3; cache;"
alias dev="ddev . npm run typo3:dev"

# DDev Composer
alias compi="ddev composer install"
alias compu="ddev composer update"

# Development Aliases
alias boot="poweron; compu; dbupdate; be; npmi; build; fe;"
alias pstorm="/mnt/c/Program\ Files/JetBrains/PhpStorm\ 2022.2/bin/phpstorm64.exe ."