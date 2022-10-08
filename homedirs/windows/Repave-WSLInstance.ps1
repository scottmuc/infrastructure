$Distribution = "Ubuntu"

wsl --terminate $Distribution
wsl --unregister $Distribution
wsl --install --distribution $Distribution