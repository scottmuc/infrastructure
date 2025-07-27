# Erebor (Lonely Mountain)

The configuration for my NAS. Named after the home of great wealth.

## Hardware

Proposed Hardware:

* AMD Ryzen 5 3600 3.6GHz 6-Core (repurposed)
* G.Skill Ripjaws V 16GB (2x8GB) DDR4-3200 CL16 RAM (repurposed)
* be quiet! Staight Power 11 550W 80+ Gold Certfied PSU (repurposed)

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

# ruby dependencies
sudo apt install git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev -y
```
