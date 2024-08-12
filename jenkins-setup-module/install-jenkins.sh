#!/bin/bash

# Update package index
echo "Updating package index..."
sudo apt-get update

# Install Java (Jenkins requires Java)
echo "Installing Java..."
sudo apt-get install -y openjdk-17-jre

# Verify java
echo "Verifing Java"
java -version

echo "Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo "Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index again
echo "Updating package index..."
sudo apt-get update

# Install Jenkins
echo "Installing Jenkins..."
sudo apt-get install -y jenkins

# Start Jenkins service
echo "Starting Jenkins..."
sudo systemctl start jenkins

# Enable Jenkins to start on boot
echo "Enabling Jenkins to start on boot..."
sudo systemctl enable jenkins

# permission to use docker 
sudo usermod -aG docker jenkins

# Restart Jenkins 
sudo systemctl restart jenkins

# Password for jenkins
echo "Jenkins is installed. The initial admin password is:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
