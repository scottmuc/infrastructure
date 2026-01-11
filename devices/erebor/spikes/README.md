## Setup Notes

https://wiki.ubuntu.com/UEFI/SecureBoot/Testing

```
# Install libvirtd as system service (cannot be in devshell)
sudo apt install libvirt-daemon-system libvirt-clients

# Add your user to libvirt group
# I need to be in the libvirt group to access the socket
# $ ls -la /var/run/libvirt/libvirt-sock
# srw-rw---- 1 root libvirt 0 Nov  7 19:53 /var/run/libvirt/libvirt-sock
sudo usermod -a -G libvirt $USER

sudo systemctl enable --now libvirtd
```
