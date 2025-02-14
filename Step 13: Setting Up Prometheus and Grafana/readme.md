# Install Prometheus and Grafana via Helm

```bash
helm install prometheus prometheus-community/prometheus
helm install grafana grafana/grafana
```
Access Grafana and add Prometheus as a data source, then import Istio dashboards for monitoring.
