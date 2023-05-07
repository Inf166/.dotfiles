# Adjusts the agents that keychain manages:
zstyle :omz:plugins:keychain agents ssh
# Add sshkey on startup but wait for use 
# (remove --noask for instant prompt and ask only if id is needed)
/usr/bin/keychain $HOME/.ssh/iwmedien
source $HOME/.keychain/$HOSTNAME-sh
eval $(keychain -q --noask --eval iwmedien)