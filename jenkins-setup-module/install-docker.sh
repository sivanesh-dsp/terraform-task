#!/bin/bash

# Update the package index
sudo apt-get update

# Install required packages
sudo apt-get install -y ca-certificates curl

# Create directory for Docker's GPG key
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker's official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Ensure the key file is readable
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again with Docker packages
sudo apt-get update

# Install Docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add the current user to the Docker group
sudo usermod -aG docker $USER

# Print Docker version to confirm installation
sudo docker --version

# docker volumes for sonarqube to be persist
# sudo docker volume create sonarqube_data
# sudo docker volume create sonarqube_logs
# sudo docker volume create sonarqube_extensions

# # installing sonarqube
# sudo docker run -d --name sonarqube \
#     -p 9000:9000 \
#     -v sonarqube_data:/opt/sonarqube/data \
#     -v sonarqube_logs:/opt/sonarqube/logs \
#     -v sonarqube_extensions:/opt/sonarqube/extensions \
#     sonarqube:lts-community
