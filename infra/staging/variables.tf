variable "github_owner" {
  description = "The repository's owner."
  type        = string
  default     = "ieuanign"
}

variable "github_repository" {
  description = "The repository whose GitHub environment this is."
  type        = string
  default     = "infra-trial"
}

variable "ssh_public_key_path" {
  description = "The deploy key's public half, written by tools/wizard/environment-staging-machine.sh."
  type        = string
  default     = "~/.ssh/infra-trial-staging.pub"
}

variable "ssh_private_key_path" {
  description = "The deploy key's private half, set as the environment's secret STAGING_SSH_KEY."
  type        = string
  default     = "~/.ssh/infra-trial-staging"
}

variable "ssh_port" {
  description = "The host port on 127.0.0.1 that reaches the host's sshd."
  type        = number
  default     = 2222
}

variable "http_port" {
  description = "The host port on 127.0.0.1 that reaches the host's proxy: the policy's health_check_url."
  type        = number
  default     = 18080
}

variable "grafana_port" {
  description = "The host port on 127.0.0.1 that reaches Grafana."
  type        = number
  default     = 13000
}
