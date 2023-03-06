#!/bin/bash
set -e
cd /home/ubuntu/status-page             # change to the status-page directory

aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 639771291841.dkr.ecr.eu-west-1.amazonaws.com #login to ECR
docker pull 639771291841.dkr.ecr.eu-west-1.amazonaws.com/status-page:latest
sudo docker run -d -p 8000:8000 --name appcontainer 639771291841.dkr.ecr.eu-west-1.amazonaws.com/status-page:latest
