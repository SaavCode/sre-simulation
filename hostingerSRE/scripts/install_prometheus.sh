#!/bin/bash

echo "🔧 Installing Prometheus..."

# Download Prometheus
cd /tmp
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
tar -xzf prometheus-2.52.0.linux-amd64.tar.gz
cp prometheus-2.52.0.linux-amd64/prometheus /usr/local/bin/
cp prometheus-2.52.0.linux-amd64/promtool /usr/local/bin/

# Move config and set up directories
mkdir -p /etc/prometheus
cp /tmp/configs/prometheus.yml /etc/prometheus/

# Create systemd service
cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Monitoring
After=network.target

[Service]
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --web.listen-address=":9090"
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Start and enable Prometheus
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus

echo "✅ Prometheus installed and running on port 9090"
