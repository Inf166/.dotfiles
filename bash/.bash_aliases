# My aliases

# ZSH
alias edit='vim ~/.zshrc'
alias src='source ~/.zshrc'

# Bundle zsh plugins via antibody
alias update-antibody='antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.sh'

# Move: cat -> bat
alias cat='bat'

# System
alias sagi='sudo apt-get install'
alias sagu='sudo apt-get update && sudo apt-get upgrade'
alias sai='sudo apt install'
alias sau='sudo apt update && sudo apt upgrade'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'

# Search
alias grep='grep --color=auto'

# Storage Space
alias diskspace='df -h'

# List
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -alF'

# Statistics
alias nvmversion='echo "$(nvm --version | awk '\''{gsub(/^v/,""); print "nvm version " $1}'\'')"'
alias npmversion='echo "$(npm --version | awk '\''{gsub(/^v/,""); print "npm version " $1}'\'')"'
alias nodeversion='echo "$(node --version | awk '\''{gsub(/^v/,""); print "node version " $1}'\'')"'
alias gitversion='echo "$(git --version)"'
alias ddevversion='echo "$(ddev --version)"'
alias dockerversion='echo "$(docker --version)"'
alias dockercomposeversion='echo "$(docker-compose --version)"'

alias stats='gitversion; nvmversion; nodeversion; npmversion; dockerversion; dockercomposeversion; ddevversion;'

alias dnpmversion='echo "$(ddev . npm --version | awk '\''{gsub(/^v/,""); print "npm version " $1}'\'')"'
alias dnodeversion='echo "$(ddev . node --version | awk '\''{gsub(/^v/,""); print "node version " $1}'\'')"'
alias dphpversion='echo "$(ddev . php --version | head -n 1 | awk '\''{print "php version " $2}'\'')"'
alias dcomposerversion='echo "$(ddev . composer --version | grep version | awk '\''{print "composer version " \$3}'\'')"'

alias ddevstats="dnpmversion; dnodeversion; dphpversion; dcomposerversion;"

# Interactive Commands
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

# Git
alias gs='git status'
alias gd='git diff'
alias glog='git log --graph --pretty=oneline --abbrev-commit'
alias gaa='git add .'
alias push='git push origin'

# Python
alias python='python3'

# Docker
alias ds='docker ps'

# DDEV
alias ddevup="ddev start"
alias ddevdown="ddev stop"
alias poweroff="ddev poweroff"

alias ddevssh="ddev ssh"
alias snapshot="ddev snapshot --name $(date +%Y-%m-%d_%H-%M)-${PWD##*/}"

# DDEV Launch
alias describe="ddev describe"
alias launch="ddev launch"
alias mail="ddev launch -m"
alias db="ddev launch -p"
alias fe="ddev launch"
alias be="ddev launch /typo3"
alias itool="ddev launch /typo3/install.php"

# DDEV TYPO3 Console Commands
alias cache="ddev typo3cms cache:flush;"
alias ccache="ddev composer du;"
alias fullcache="cache; ccache;"
alias dbupdate="ddev typo3cms database:updateschema;"
alias langupdate="ddev typo3cms language:update"
alias genpackages="ddev typo3cms install:generatepackagestates"
alias fixfolder="ddev typo3cms install:fixfolderstructure;"
alias cadmin="ddev typo3cms backend:createadmin"
alias t3uwp="ddev typo3cms upgrade:prepare"
alias t3uwl="ddev typo3cms upgrade:list"
alias t3uw="ddev typo3cms upgrade:run"

# DDEV NPM
alias npmi="ddev . npm i --no-audit --no-fund"
alias npmb="ddev . npm run target; cache;"
alias npmw="ddev . npm run target:dev"
alias npmlc="ddev npm run lint:check"
alias npmlf="ddev npm run lint:fix"

alias fucknpm="rm -rf node_modules; rm package-lock.json"

# DDEV Storybook-cli
alias sbstart='ddev . storybook start'
alias sbbuild='ddev . storybook build'
alias sbinit='ddev . npx -p @storybook/cli sb init'

# DDEV Grunt-cli
alias gruntw='ddev . grunt watch'

# DDEV Composer
alias compidry="ddev composer install --dry-run"
alias compi="ddev composer install"
alias compind="ddev composer install --no-dev"
alias compu="ddev composer update"
alias compuwa="ddev composer update --with-all-dependencies"
alias compreq="ddev composer req"
alias compreqd="ddev composer require-dev"
alias complint="ddev composer lint && ddev composer phpstan;"

alias fuckcomposer="ddev composer clear-cache; rm -rf vendor; rm composer.lock"

# Development Aliases
alias boot="ddevup; compu; dbupdate; be; npmi; npmb; fe;"
alias lintall="npmlc; npmlf; complint;"
alias pstorm="/mnt/c/Program\ Files/JetBrains/PhpStorm\ 2022.2/bin/phpstorm64.exe ."
alias ps="pstorm"
