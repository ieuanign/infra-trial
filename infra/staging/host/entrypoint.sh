#!/bin/sh
# Starts the host: its Docker, its scheduler and, in the foreground, sshd.
set -eu

# A Docker inside a container on cgroup v2 moves this process out of the root cgroup first, as Docker's own
# dind script does, so the inner Docker can enable controllers.
if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
  mkdir -p /sys/fs/cgroup/init
  xargs -rn1 < /sys/fs/cgroup/cgroup.procs > /sys/fs/cgroup/init/cgroup.procs || :
  sed -e 's/ / +/g' -e 's/^/+/' < /sys/fs/cgroup/cgroup.controllers > /sys/fs/cgroup/cgroup.subtree_control || :
fi

# The host key lives on its own volume, so a replaced container keeps its fingerprint.
[ -f /etc/ssh/keys/ssh_host_ed25519_key ] || ssh-keygen -q -t ed25519 -N '' -f /etc/ssh/keys/ssh_host_ed25519_key

install -d -m 0700 -o deploy -g deploy /home/deploy/.ssh
printf '%s\n' "$AUTHORIZED_KEY" > /home/deploy/.ssh/authorized_keys
chown deploy:deploy /home/deploy/.ssh/authorized_keys
chmod 0600 /home/deploy/.ssh/authorized_keys

# Unattended security updates, daily.
cron

dockerd > /var/log/dockerd.log 2>&1 &

mkdir -p /run/sshd
exec /usr/sbin/sshd -D -e
