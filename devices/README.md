# LAN Device Inventory

Much of the context around the need for this information has been documented in the
[host naming convention][issue-72] issue.

[issue-72]: https://github.com/scottmuc/infrastructure/issues/72

### Network Topology

```
Network           : 192.168.2.0/24
Gateway           : 192.168.2.1
Static IP Range   : 192.168.2.10-192.168.2.99
DHCP Range        : 192.168.2.150-192.168.2.199
Backup DHCP Range : 192.168.2.100-192.168.2.149
DNS Resolver      : 192.168.2.10
Search Domain     : middle-earth.internal
```

#### Inventory

| Device                  | Hostname            | IP Discovery Method | IP Address   | Open Ports                    |
|-------------------------|---------------------|---------------------|--------------|-------------------------------|
| Telekom Speednet Router |                     | Static              | 192.168.2.1  | 80                            |
| Raspberry PI            | [pippin][pippin]    | Static              | 192.168.2.10 | 22, 53, 67, 80, 443           |
|                         |                     |                     |              | 3000 (grafana web ui)         |
|                         |                     |                     |              | 4533 (navidrome metrics)      |
|                         |                     |                     |              | 9090 (prometheus)             |
|                         |                     |                     |              | 9100 (node_exporter metrics)  |
| Windows PC              | gandalf             | DHCP                | random       | 9182 (node_exporter metrics)  |
| Brother Printer         | denethor            | DHCP                | random       | 80                            |
| Samsung Galaxy S7       | sam                 | DHCP                | random       |                               |
| Framework 13" Laptop    | [frodo][frodo]      | DHCP                | random       |                               |
| Netgear Switch 1        | kili                | DHCP                | random       | 80                            |
| Netgear Switch 2        | fili                | DHCP                | random       | 80                            |
| Samsung TV              | sauron              | DHCP                | random       |                               |
| M3 Macbook Pro          | treebeard           | DHCP                | random       |                               |
| RIPE Atlas Node         | palantir            | DHCP                | random       |                               |
| Miele Washing Machine   | elrond              | DHCP                | random       |                               |
| 2014 Macbook Air        | [gollum][gollum]    | DHCP                | random       |                               |


[pippin]: pippin/
[frodo]: frodo/
[gollum]: gollum/
