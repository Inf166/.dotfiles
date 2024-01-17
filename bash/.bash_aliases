# My aliases

# ZSH
alias edit='vim ~/.zshrc'
alias src='source ~/.zshrc'

# Bundle zsh plugins via antibody
alias update-antibody='antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.sh'

# Move: cat -> bat
alias cat='batcat'

# System
alias sagi='sudo apt-get install'
alias sagu='sudo apt-get update && sudo apt-get upgrade'
alias sai='sudo apt install'
alias sau='sudo apt update && sudo apt upgrade'

# Nice Commands for easier work
alias newsletter='mjml index.mjml -o index.html'
alias add-pre-commit="cp ~/.git/hooks/pre-commit .git/hooks/pre-commit; chmod +x .git/hooks/pre-commit;"

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

# Video compression
compress_video() {
    if [ -z "$1" ]; then
        echo "Usage: compress_video <filename>"
        return 1
    fi

    input_filename="$1"
    output_filename="${input_filename%.*}_compressed.mp4"

    ffmpeg -i "${input_filename}" -c:v libx264 -tune film -profile:v main -crf 23 -c:a libfdk_aac -b:a 128k -ac 2 "${output_filename}"
}

compress_image() {
    # Überprüfe, ob eine Datei als Argument übergeben wurde
    if [ -z "$1" ]; then
        echo "Usage: compress_image <filename>"
        return 1
    fi
    INPUT_FILE="$1"
    OUTPUT_FILE="${INPUT_FILE%.png}_optimized.png"

    # Verlustbehaftete Komprimierung mit pngquant
    # Benutze einen höheren Qualitätsbereich und den --speed Parameter für höhere Qualität
    # Reduziere die Farben auf 256
    pngquant --quality=65-80 --speed 1 --skip-if-larger --strip --output "$OUTPUT_FILE" "$INPUT_FILE"

    # Verwendung von optipng für verlustfreie Optimierung
    optipng -o7 -strip all "$OUTPUT_FILE"

    # Weitere Optimierung und Entfernen unnötiger Daten mit pngcrush
    pngcrush -rem alla -reduce -brute "$OUTPUT_FILE" "$OUTPUT_FILE"

    # Rename the output file to the input file
    mv "$OUTPUT_FILE" "$INPUT_FILE"

    echo "Optimization complete. Optimized file saved as $INPUT_FILE"
}

alias compress-images='find -name '*.png' -print0 | compress_image'

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
alias ddevup="ddev start; ddev auth ssh;"
alias ddevdown="ddev stop"
alias poweroff="ddev poweroff"

alias ddevssh="ddev ssh"
alias snapshot="ddev snapshot --name $(date +%Y-%m-%d_%H-%M)-${PWD##*/}"
alias dremove="ddev delete --omit-snapshot"

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
alias build-d="ddev . bin/md2pdf build --config bifa-documentation.yaml"
alias build-g="ddev . bin/md2pdf build --config editor-guide.yaml;"
alias lintall="npmlc; npmlf; complint;"
alias pstorm="/mnt/c/Program\ Files/JetBrains/PhpStorm\ 2023.1/bin/phpstorm64.exe ."
alias wstorm="/mnt/c/Program\ Files/JetBrains/WebStorm\ 2023.1/bin/webstorm64.exe ."
alias ij="/mnt/c/Program\ Files/JetBrains/IntelliJ\ IDEA\ 2022.3.3/bin/idea64.exe ."
alias ps="pstorm"
