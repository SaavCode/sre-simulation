# Print Prometheus web UI link
output "prometheus_url" {
  value = "http://${var.vps_ip}:9090"
}

# Print Grafana web UI link
output "grafana_url" {
  value = "http://${var.vps_ip}:3000"
}

# Print optional status page (served separately via Python/NGINX)
output "status_dashboard_url" {
  value = "http://${var.vps_ip}:8080"
}
