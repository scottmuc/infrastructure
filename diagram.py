from diagrams import Cluster, Diagram
from diagrams.onprem.monitoring import Grafana, Prometheus
from diagrams.generic.network import Router, Switch
from diagrams.generic.os import Windows, LinuxGeneral
from diagrams.onprem.logging import Rsyslog

with Diagram("Home Network", show=False):
  router = Router("Telekom Router")

  with Cluster("TV Stand"):
    tv_switch = Switch("TV Netgear Switch")

  with Cluster("Desktop"):
    desktop_switch = Switch("Desktop Netgear Switch")
    desktop = Windows("Desktop PC")

  with Cluster("Raspberry PI"):
    pi = LinuxGeneral("Debian")
    Prometheus("metrics")
    Grafana("monitoring")
    Rsyslog("log forwarding")

  pi >> router
  desktop_switch >> router
  tv_switch >> desktop_switch
  desktop >> desktop_switch
