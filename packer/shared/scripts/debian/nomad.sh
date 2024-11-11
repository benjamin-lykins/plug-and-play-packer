#!/bin/bash -ex
export DEBIAN_FRONTEND=noninteractive

echo "Install the required packages."
apt-get update &&
    apt-get install wget gpg coreutils

echo "Add the HashiCorp GPG key."
wget -O- https://apt.releases.hashicorp.com/gpg |
    gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "Add the HashiCorp repository."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
    sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "Install Nomad."
sudo apt-get update && sudo apt-get install nomad

echo "Install the CNI plugins."
export ARCH_CNI=$([ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)
export CNI_PLUGIN_VERSION=v1.6.0
curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGIN_VERSION}/cni-plugins-linux-${ARCH_CNI}-${CNI_PLUGIN_VERSION}".tgz &&
    sudo mkdir -p /opt/cni/bin &&
    sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz &&
    rm cni-plugins.tgz
