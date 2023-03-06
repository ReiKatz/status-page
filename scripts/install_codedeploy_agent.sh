#!/bin/bash
set -e
cd /home/ubuntu
sudo yum update -y
sudo yum install -y ruby
sudo yum install -y awscli
wget https://aws-codedeploy-eu-west-1.s3.eu-west-1.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
