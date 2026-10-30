# Staging's virtual machine: one container on this Machine's Docker, with sshd and a Docker of its own.
# Every name starts infra-trial-staging; nothing else on this Docker is touched.

locals {
  name      = "infra-trial-staging"
  host_hash = sha1(join("", [for f in sort(fileset("${path.module}/host", "**")) : filesha1("${path.module}/host/${f}")]))
}

resource "docker_image" "host" {
  name = "${local.name}-host:${substr(local.host_hash, 0, 12)}"

  build {
    context = "${path.module}/host"
  }

  triggers = {
    host = local.host_hash
  }
}

# The host's disk: its images, containers and volumes. Data-holding.
resource "docker_volume" "docker" {
  name = "${local.name}-docker"
}

# The host's sshd keys, kept across a replaced container so its fingerprint stays.
resource "docker_volume" "ssh" {
  name = "${local.name}-ssh"
}

resource "docker_container" "host" {
  name     = local.name
  hostname = "staging"
  image    = docker_image.host.image_id
  restart  = "unless-stopped"

  # The host runs a Docker of its own.
  privileged = true

  env = [
    "AUTHORIZED_KEY=${trimspace(file(pathexpand(var.ssh_public_key_path)))}",
  ]

  ports {
    internal = 22
    external = var.ssh_port
    ip       = "127.0.0.1"
  }

  ports {
    internal = 80
    external = var.http_port
    ip       = "127.0.0.1"
  }

  ports {
    internal = 3000
    external = var.grafana_port
    ip       = "127.0.0.1"
  }

  volumes {
    volume_name    = docker_volume.docker.name
    container_path = "/var/lib/docker"
  }

  volumes {
    volume_name    = docker_volume.ssh.name
    container_path = "/etc/ssh/keys"
  }

  labels {
    label = "infra-trial.environment"
    value = "staging"
  }
}
