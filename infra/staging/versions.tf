terraform {
  required_version = ">= 1.8"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.6"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.13"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.9"
    }
  }

  # Docker has no object storage, so the state stays on this Machine, outside the repository.
  backend "local" {
    path = pathexpand("~/paperclip/state/infra-trial/staging/terraform.tfstate")
  }
}

# The endpoint is DOCKER_HOST, set from INFRA_CREDENTIAL_PROVIDER_STAGING at apply.
provider "docker" {}

# The token is GITHUB_TOKEN, set from INFRA_CREDENTIAL_GITHUB at apply.
provider "github" {
  owner = var.github_owner
}
