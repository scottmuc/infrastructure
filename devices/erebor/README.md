# Erebor (Lonely Mountain)

The configuration for my NAS. Named after the home of great wealth.

## Setup Notes

https://wiki.ubuntu.com/UEFI/SecureBoot/Testing
Virtualbox needs a MoK Machine-owner Key for Secure Boot UEFI

```

sudo apt install virtualbox
# To stop USB error messages
sudo usermod -a -G vboxusers "$(whoami)"

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant
```
