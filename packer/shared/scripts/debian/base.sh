#!/bin/bash -ex
export DEBIAN_FRONTEND=noninteractive

# Update package list and upgrade all packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install some basic packages
sudo apt-get install -y curl wget git

# Print completion message
echo "Base setup completed successfully."
