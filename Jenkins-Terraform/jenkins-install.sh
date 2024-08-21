#!/bin/bash

# Update package lists
sudo apt update -y

# Install required packages
sudo apt install -y openjdk-17-jre openjdk-17-jdk docker.io curl unzip wget apt-transport-https gnupg lsb-release

# Add jenkins user to docker group
sudo usermod -aG docker jenkins

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Kubectl
sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install -y terraform

# Install Trivy
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update
sudo apt install -y trivy

# Install Helm
sudo snap install helm --classic

# Install SonarQube
echo "Installing SonarQube..."
if sudo docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community; then
  echo "SonarQube container started successfully."
else
  echo "Failed to start SonarQube container."
  exit 1
fi

# Install Nexus
echo "Installing Nexus..."
if sudo docker run -d --name nexus -p 8081:8081 sonatype/nexus3; then
  echo "Nexus container started successfully."
else
  echo "Failed to start Nexus container."
  exit 1
fi

echo "Installation checks for Docker containers:"
docker ps -a
