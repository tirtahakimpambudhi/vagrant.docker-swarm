#!/bin/bash

# Set DNS server (Google DNS)
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# Install Dependencies
echo "Installing dependencies ..."
sudo apt-get update -y

# Install Net Tools
echo "Installing net-tools..."
sudo apt install -y net-tools dos2unix  

# Install JSON Processor (jq)
echo "Installing jq..."
sudo apt install -y jq

# Install Docker
echo "Installing Docker..."
curl -sSL https://get.docker.com/ | sh

# Add the user 'vagrant' to the docker group
echo "Adding user 'vagrant' to the Docker group..."
sudo usermod -aG docker vagrant

# Check if Docker is installed
echo "Checking Docker installation..."
if ! command -v docker &> /dev/null
then
    echo "Docker could not be installed or found. Exiting."
    exit 1
else
    echo "Docker is installed."
fi

# Check if jq is installed
echo "Checking jq installation..."
if ! command -v jq &> /dev/null
then
    echo "jq could not be installed or found. Exiting."
    exit 1
else
    echo "jq is installed."
fi

echo "All dependencies are installed and ready to use."
