$Distribution = "Ubuntu"

wsl --set-default-version 2
wsl --terminate $Distribution
wsl --unregister $Distribution
wsl --install --distribution $Distribution
