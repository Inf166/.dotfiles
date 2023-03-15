### ALIASES ###

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# List
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'

# Date
alias datum="date + %Y-%m-%d_%H-%M"

# Dangerzone
alias mv='mv -i'
alias rm='rm -i'

# Git
alias gs='git status'
alias gd='git diff'

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
alias eclass="cd eclass-assets; npm run typo3; ..; ddev composer run assets:copy; cache;"
alias boot="poweron; compi; dbupdate; be; npmi; build; fe;"