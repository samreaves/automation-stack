#!/usr/bin/env bash
echo “Updating apt-get package manager…”
sudo apt-get update -y
echo “Installing and setting up Docker…”
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual -y
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository “deb [arch=amd64] http://download.docker.com/linux/ubuntu $(lsb_release -cs) stable”
sudo apt-get update -y
sudo apt-get install docker-ce -y
sudo apt install docker.io -y
echo “Configuring user…”
sudo usermod -aG docker vagrant
sudo apt-get update -y
echo "Installing docker-compose"
sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "docker-compose installed"
echo "Installing terraform"
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip
unzip terraform_0.11.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm -rf terraform_0.11.5_linux_amd64.zip
echo "terraform installed"
echo “Completed provisioning”
