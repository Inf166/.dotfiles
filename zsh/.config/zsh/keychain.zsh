# Adjusts the agents that keychain manages:
zstyle :omz:plugins:keychain agents gpg,ssh
zstyle :omz:plugins:keychain identities iwmedien iwmedien-nb-705
# Add sshkey on startup but wait for use 
# (remove --noask for instant prompt and ask only if id is needed)
source $HOME/.keychain/NB-705-sh
eval $(keychain -q --noask --eval iwmedien)