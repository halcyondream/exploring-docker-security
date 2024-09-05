#!/bin/bash

function getRandomByteHash() {
    # Hash a stream of 64-byte (512-bit) random data.
    head -c 64 /dev/urandom | sha256sum | cut -d ' ' -f 1
}

echo "root:$(getRandomByteHash)" | chpasswd
echo "vagrant:$(getRandomByteHash)" | chpasswd

# Basic setup...
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Set the host to use Port 2222.
#sudo sed -i 's/^#Port 22/Port 2222/' /etc/ssh/sshd_config && \
#sudo systemctl restart ssh

# Install the official Docker.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker

# Misconfigure the local socket/daemon.
cp /provision/daemon.json /etc/docker/daemon.json
mkdir -p /etc/systemd/system/docker.service.d
cp /provision/override.conf /etc/systemd/system/docker.service.d/override.conf
systemctl daemon-reload
systemctl restart docker

# Build and launch the "pipeline" container.
docker build -t pipeline /provision/pipeline
docker run \
    --pid=host \
    --privileged \
    --detach \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --publish 2222:22 \
    pipeline
