#!/bin/bash

apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

systemctl start docker
systemctl enable docker

cp /vagrant/daemon.json /etc/docker/daemon.json
mkdir -p /etc/systemd/system/docker.service.d
cp /vagrant/override.conf /etc/systemd/system/docker.service.d/override.conf
systemctl daemon-reload
systemctl restart docker

docker build -t orchestrator /vagrant/orchestrator
docker run --privileged -d -v /var/run/docker.sock:/var/run/docker.sock -p 22:22 orchestrator
