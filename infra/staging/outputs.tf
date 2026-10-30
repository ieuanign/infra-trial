output "ssh" {
  description = "How to reach the host: ssh staging, through the alias the Machine part writes."
  value       = "deploy@127.0.0.1:${var.ssh_port}"
}

output "health_check_url" {
  description = "The policy's health_check_url, served by the host's proxy."
  value       = local.variables.HEALTH_CHECK_URL
}

output "grafana_url" {
  description = "Grafana, on this Machine only."
  value       = local.variables.GRAFANA_URL
}
