### Functions for aliases ###
nvmv() {
	nvm --version | awk '{print "nvm version " $1}';
}

npmv() {
	npm --version | awk '{print "npm version " $1}';
}

phpstorm() {
	'/mnt/c/Program Files/JetBrains/PhpStorm 2022.2/bin/phpstorm64.exe' .;
	return;
}

# My aliases

# zsh
alias edit='vim ~/.zshrc'
alias src='source ~/.zshrc'

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

# Date
alias datum="date + %Y-%m-%d_%H-%M"

# dangerzone
alias mv='mv -i'
alias rm='rm -i'

# git
alias gs='git status'
alias gd='git diff'
alias glog='git log --graph --pretty=oneline --abbrev-commit'
alias gaa='git add .'
alias push='git push origin'

# Bachelor
alias thesis='jc thesis; code .; explorer.exe .;'

# Docker
alias ds='docker ps'

# DDev
alias poweron="ddev start"
alias poweroff="ddev poweroff"
alias fuckthis="ddev stop"
alias snapshot="ddev snapshot working_before_"

# DDev launch windows
alias launch="ddev launch"
alias mail="ddev launch -m"
alias db="ddev launch -p"
alias fe="ddev launch"
alias be="ddev launch /typo3"
alias itool="ddev launch /typo3/install.php"

# DDev TYPO3
alias cache="ddev typo3cms cache:flush"
alias dbupdate="ddev typo3cms database:updateschema"

# DDev Node Js
alias npmi="ddev . npm i"
alias build="ddev . npm run typo3; cache;"
alias dev="ddev . npm run typo3:dev"

# DDev Composer
alias compi="ddev composer install"
alias compu="ddev composer update"

# Development Aliases
alias boot="poweron; compi; dbupdate; be; npmi; build; fe;"
alias ps="phpstorm"