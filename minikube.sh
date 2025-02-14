#!/bin/bash

# Exit on error
set -e

echo "Updating system packages..."
sudo yum update -y

echo "Installing required dependencies..."
sudo yum install -y curl wget conntrack

# Install Docker
echo "Installing Docker..."
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Install Minikube
echo "Downloading Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl

# Start Minikube
echo "Starting Minikube..."
minikube start --driver=docker --force

echo "Minikube installation completed!"
minikube status
