#!/bin/bash

echo "🔧 Installing Node Exporter..."

# Download and install Node Exporter
cd /tmp
curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
tar -xzf node_exporter-1.8.1.linux-amd64.tar.gz
cp node_exporter-1.8.1.linux-amd64/node_exporter /usr/local/bin/

# Create systemd service
cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
ExecStart=/usr/local/bin/node_exporter
Restart=always

[Install]
WantedBy=default.target
EOF

# Start and enable service
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter

echo "✅ Node Exporter installed and running on port 9100"
