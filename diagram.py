from diagrams import Cluster, Diagram
from diagrams.onprem.monitoring import Grafana, Prometheus

with Diagram("Home Network", show=False):
  with Cluster("Raspberry PI"):
    metrics = Prometheus("metrics")
    metrics << Grafana("monitoring")
