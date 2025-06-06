# Hostinger VPS Monitoring Stack

This project sets up a basic monitoring stack using Prometheus, Node Exporter, and a custom status page. The goal is to simulate a simple SRE environment on a self-managed Linux server and practice concepts like observability, system metrics, incident detection, and postmortems.

## Stack

- **Prometheus** – metrics collection and querying
- **Node Exporter** – exposes system-level metrics (CPU, memory, disk, etc.)
- **Custom HTML dashboard** – basic JS-based health page that reads Prometheus API
- **Terraform (local execution)** – provisions the stack via remote SSH
- **macOS local test environment** – used to simulate and validate setup before deployment to Hostinger VPS

## Features Implemented

- Local installation of Prometheus and Node Exporter
- Custom Prometheus config to scrape Node Exporter
- HTML/JS status page using Prometheus HTTP API
- Successfully tested:
  - CPU load display
  - Used RAM (adjusted for macOS-limited metrics)
- Confirmed metric availability by parsing `/metrics` endpoint

## File Structure

```plaintext
hostinger-sre/
├── main.tf                     # Terraform SSH provisioner for remote setup
├── variables.tf                # IP and auth configuration
├── outputs.tf                  # Shows exposed service URLs
├── scripts/                    # Installs Prometheus, Grafana, Node Exporter
│   ├── install_node_exporter.sh
│   ├── install_prometheus.sh
│   └── install_grafana.sh
├── configs/
│   ├── prometheus.yml          # Prometheus scrape config
│   ├── grafana_dashboard.json # (Optional) prebuilt dashboard
│   └── dashboard.yml           # Grafana provisioning (optional)
├── web/
│   └── status.html             # Frontend dashboard with Prometheus queries
├── postmortem.md               # For documenting incident simulation
├── README.md                   # Project documentation

## Local Testing Setup (macOS)

1. **Start Node Exporter**

   ```bash
   ./node_exporter
   ```

2. **Start Prometheus**

   ```bash
   prometheus --config.file=configs/prometheus.yml
   ```

3. **Run the frontend dashboard**

   From inside the `web/` folder:

   ```bash
   python3 -m http.server 8080
   ```

4. **Access in browser:**

   - Prometheus: [http://localhost:9090](http://localhost:9090)
   - Status Page: [http://localhost:8080/status.html](http://localhost:8080/status.html)

   You should see live CPU load and used RAM (in GB).
