# Staging's host: Debian with sshd, a Docker of its own with Compose, and unattended security updates.
FROM debian:trixie-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates curl gnupg openssh-server sudo cron unattended-upgrades iptables procps tar \
 && install -m 0755 -d /etc/apt/keyrings \
 && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
 && echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian trixie stable" \
      > /etc/apt/sources.list.d/docker.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
 && rm -rf /var/lib/apt/lists/*

# The login user: runs docker, and `sudo -n` for prune.sh's rotated-log cleanup. Key login only.
RUN useradd --create-home --shell /bin/bash --groups docker deploy \
 && usermod -p '*' deploy \
 && echo 'deploy ALL=(root) NOPASSWD: /usr/bin/find /var/log *' > /etc/sudoers.d/deploy \
 && chmod 0440 /etc/sudoers.d/deploy

COPY sshd_config /etc/ssh/sshd_config.d/staging.conf
COPY unattended-upgrades /etc/cron.daily/unattended-upgrades-staging
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 0755 /etc/cron.daily/unattended-upgrades-staging /usr/local/bin/entrypoint.sh

EXPOSE 22 80 3000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
