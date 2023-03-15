# Restart docker?
wsl.exe -u root service docker status > /dev/null || wsl.exe -u root service docker start > /dev/null