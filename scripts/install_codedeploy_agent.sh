#!/bin/bash
set -e
cd /home/ubuntu
sudo apt update -y
sudo apt install -y ruby
sudo apt install -y awscli
wget https://aws-codedeploy-eu-west-1.s3.eu-west-1.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
