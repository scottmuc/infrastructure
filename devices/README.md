# LAN Documentation

Much of the context around the need for this information has been documented in the
[host naming convention][issue-72] issue.

[issue-72]: https://github.com/scottmuc/infrastructure/issues/72

### Network Topology

```
Network           : 192.168.2.0/24
Gateway           : 192.168.2.1
Search Domain     : middle-earth.internal
DNS Resolver(s)   : 192.168.2.10,192.168.2.11
Static IP Range   : 192.168.2.10-192.168.2.99
DHCP Range        : 192.168.2.150-192.168.2.199
Backup DHCP Range : 192.168.2.100-192.168.2.149
```

#### Device Inventory and IP Address Management

| Device                  | Hostname             | IP Discovery Method | IP Address   | Open Ports                       |
|-------------------------|----------------------|---------------------|--------------|----------------------------------|
| Telekom Speednet Router |                      | Static              | 192.168.2.1  | 80                               |
| Raspberry PI            | [pippin][pippin]     | Static              | 192.168.2.10 | 22, 53, 67, 80, 443              |
|                         |                      |                     |              | 3000 (grafana web ui)            |
|                         |                      |                     |              | 9090 (prometheus)                |
|                         |                      |                     |              | 9100 (node_exporter metrics)     |
|                         |                      |                     |              | 9153 (dnsmasq_exporter metrics)  |
|                         |                      |                     |              | 9167 (unbound_exporter metrics)  |
| Dell XPS 9550           | [merry][merry]       | Static              | 192.168.2.11 | 22, 53, 80, 443                  |
|                         |                      |                     |              | 4533 (navidrome metrics)         |
|                         |                      |                     |              | 8080 (concourse-web)             |
|                         |                      |                     |              | 8200 (vault)                     |
|                         |                      |                     |              | 9100 (node_exporter metrics)     |
|                         |                      |                     |              | 9167 (unbound_exporter metrics)  |
| Brother Printer         | denethor             | DHCP                | 192.168.2.12 | 80                               |
| Netgear Switch 1        | kili                 | DHCP                | 192.168.2.13 | 80                               |
| Netgear Switch 2        | fili                 | DHCP                | 192.168.2.14 | 80                               |
| Samsung TV              | sauron               | DHCP                | 192.168.2.15 |                                  |
| RIPE Atlas Node         | palantir             | DHCP                | 192.168.2.16 |                                  |
| Miele Washing Machine   | elrond               | DHCP                | 192.168.2.17 |                                  |
| Radoff                  | [radagast][radagast] | DHCP                | 192.168.2.18 |                                  |
| FreeBSD NAS             | [erebor][erebor]     | Static              | 192.168.2.19 |                                  |
| Windows PC              |                      |                     |              |                                  |
| \|- Windows boot        | gandalf              | Static              | 192.168.2.20 | 9182 (node_exporter metrics)     |
| \|- FreeBSD boot        | gandalf              | Static              | 192.168.2.21 |                                  |
| Google Pixel 8          | sam                  | DHCP                | random       |                                  |
| Framework 13" Laptop    | [frodo][frodo]       | DHCP                | random       |                                  |
| M3 Macbook Pro          | treebeard            | DHCP                | random       |                                  |
| 2014 Macbook Air        | [gollum][gollum]     | DHCP                | random       |                                  |


[erebor]: erebor/
[frodo]: frodo/
[gollum]: gollum/
[merry]: merry/
[pippin]: pippin/
[radagast]: radagast/
