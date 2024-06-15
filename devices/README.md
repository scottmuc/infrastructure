# LAN Device Inventory

Much of the context around the need for this information has been documented in the
[host naming convention][issue-72] issue.

[issue-72]: https://github.com/scottmuc/infrastructure/issues/72

### Network Topology

Network           : 192.168.2.0/24  
Gateway           : 192.168.2.1  
Static IP Range   : 192.168.2.10-192.168.2.99..
DHCP Range        : 192.168.2.150-192.168.2.199  
Backup DHCP Range : 192.168.2.100-192.168.2.149  
DNS Resolver      : 192.168.2.10  
Search Domain     : middle-earth.internal  

#### Inventory

| Device                  | Hostname  | IP Discover Method | IP Address   |
|-------------------------|-----------|--------------------|--------------|
| Telekom Speednet Router |           | Static             | 192.168.2.1  |
| Raspberry PI            | pippin    | Static             | 192.168.2.10 |
| Windows PC              | gandalf   | DHCP               | 192.168.2.12 |
| Brother Printer         | denethor  | DHCP               | 192.168.2.13 |
| Samsung Galaxy S7       | sam       | DHCP               | 192.168.2.14 |
| Framework 13" Laptop    | frodo     | DHCP               | 192.168.2.15 |
| Netgear Switch 1        | kili      | DHCP               | 192.168.2.16 |
| Netgear Switch 2        | fili      | DHCP               | 192.168.2.17 |
| Samsung TV              | sauron    | DHCP               | 192.168.2.18 |
| M3 Macbook Pro          | treebear  | DHCP               | 192.168.2.19 |
| RIPE Atlas Node         | palantir  | DHCP               | 192.168.2.20 |
| Miele Washing Machine   | elrond    | DHCP               | 192.168.2.21 |
| 2014 Macbook Air        | gollum    | DHCP               | random       |
