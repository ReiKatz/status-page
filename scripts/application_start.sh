#!/bin/bash
set -e
cd /home/ubuntu/status-page             # change to the status-page directory
sudo docker-compose pull                # pull the latest images from the registry
sudo docker-compose down                # stop and remove any existing containers
sudo docker-compose up --build -d app   # start app container
