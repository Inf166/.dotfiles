# Adjusts the agents that keychain manages:
zstyle :omz:plugins:keychain agents ssh
# Add sshkey on startup but wait for use
# (remove --noask for instant prompt and ask only if id is needed)
eval $(keychain -q --noask --eval id_ed25519)