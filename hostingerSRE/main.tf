# Terraform needs null and local providers for remote exec and file upload
provider "null" {}
provider "local" {}

resource "null_resource" "provision_vps" {
  # Define SSH connection to your VPS
  connection {
    type     = "ssh"
    host     = var.vps_ip
    user     = var.vps_user
    password = var.vps_password
    port     = var.vps_port
    timeout  = "2m"
  }

  # Upload shell scripts from your Mac to the VPS under /tmp/scripts
  provisioner "file" {
    source      = "scripts/"
    destination = "/tmp/scripts"
  }

  # Upload Prometheus/Grafana config files to /tmp/configs
  provisioner "file" {
    source      = "configs/"
    destination = "/tmp/configs"
  }

  # Run the scripts remotely in order
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scripts/*.sh",                  # Make all scripts executable
      "bash /tmp/scripts/install_node_exporter.sh",  # Install Node Exporter
      "bash /tmp/scripts/install_prometheus.sh",     # Install Prometheus + config
      "bash /tmp/scripts/install_grafana.sh"         # Install Grafana
    ]
  }
}
