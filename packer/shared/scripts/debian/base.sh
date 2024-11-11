#!/bin/bash -ex
export DEBIAN_FRONTEND=noninteractive

# Update package list and upgrade all packages
apt-get update -y
apt-get upgrade -y

# Print completion message
echo "Base setup completed successfully."
