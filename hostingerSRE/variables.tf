# Public IP address of your VPS (example: 123.45.67.89)
variable "vps_ip" {
  description = "Public IP address of the VPS"
  type        = string
}

# SSH user (usually root)
variable "vps_user" {
  description = "SSH username for the VPS"
  type        = string
  default     = "root"
}

# SSH password (used instead of key auth for this example)
variable "vps_password" {
  description = "SSH password for the VPS (optional if using key auth)"
  type        = string
  sensitive   = true
}

# SSH port (22 by default, change if yours is different)
variable "vps_port" {
  description = "SSH port (default is 22)"
  type        = number
  default     = 22
}
