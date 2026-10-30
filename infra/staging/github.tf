# GitHub environment staging: deployable from main alone, with what the deployment workflow reads.

# tools/wizard/environment-staging-repository.sh creates the environment to set its Telegram secret.
import {
  to = github_repository_environment.staging
  id = "${var.github_repository}:staging"
}

resource "github_repository_environment" "staging" {
  repository  = var.github_repository
  environment = "staging"

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_environment_deployment_policy" "main" {
  repository     = var.github_repository
  environment    = github_repository_environment.staging.environment
  branch_pattern = "main"
}

locals {
  variables = {
    STAGING_SSH_HOST = "127.0.0.1"
    STAGING_SSH_PORT = tostring(var.ssh_port)
    STAGING_SSH_USER = "deploy"
    HEALTH_CHECK_URL = "http://127.0.0.1:${var.http_port}/health"
    GRAFANA_URL      = "http://127.0.0.1:${var.grafana_port}"
  }
}

resource "github_actions_environment_variable" "staging" {
  for_each = local.variables

  repository    = var.github_repository
  environment   = github_repository_environment.staging.environment
  variable_name = each.key
  value         = each.value
}

resource "github_actions_environment_secret" "ssh_key" {
  repository      = var.github_repository
  environment     = github_repository_environment.staging.environment
  secret_name     = "STAGING_SSH_KEY"
  plaintext_value = file(pathexpand(var.ssh_private_key_path))
}

resource "random_password" "grafana" {
  length  = 32
  special = false
}

resource "github_actions_environment_secret" "grafana" {
  repository      = var.github_repository
  environment     = github_repository_environment.staging.environment
  secret_name     = "GRAFANA_ADMIN_PASSWORD"
  plaintext_value = random_password.grafana.result
}
