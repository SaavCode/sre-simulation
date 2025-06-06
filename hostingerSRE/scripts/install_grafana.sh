#!/bin/bash

echo "🔧 Installing Grafana..."

# Install Grafana
apt-get update -y
apt-get install -y software-properties-common
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main" -y
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
apt-get update -y
apt-get install -y grafana

# Create dashboard directories
mkdir -p /etc/grafana/provisioning/dashboards
mkdir -p /var/lib/grafana/dashboards

# Copy provisioning config and dashboard JSON
cp /tmp/configs/dashboard.yml /etc/grafana/provisioning/dashboards/
cp /tmp/configs/grafana_dashboard.json /var/lib/grafana/dashboards/basic.json

# Update provisioning config to point to the JSON location
cat <<EOF > /etc/grafana/provisioning/dashboards/dashboards.yml
apiVersion: 1

providers:
  - name: 'auto-loaded'
    orgId: 1
    folder: ''
    type: file
    options:
      path: /var/lib/grafana/dashboards
      updateIntervalSeconds: 30
      allowUiUpdates: true
EOF

# Enable and start Grafana
systemctl enable grafana-server
systemctl start grafana-server

echo "✅ Grafana installed with auto-loaded dashboard on port 3000"
