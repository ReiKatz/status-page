#!/bin/bash
set -e
sudo docker-compose pull                # pull the latest images from the registry
sudo docker-compose down                # stop and remove any existing containers
sudo docker-compose up -d redis db      # start Redis and database containers
