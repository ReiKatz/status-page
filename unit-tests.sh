#!/bin/bash

# Define the Docker Compose file to use
DOCKER_COMPOSE_FILE="./docker-compose.yml"

# Install pytest-django
pip install pytest-django

# Start the Docker Compose services in detached mode
docker-compose -f $DOCKER_COMPOSE_FILE up -d

# Run the unit tests using the Docker Compose services
docker-compose -f $DOCKER_COMPOSE_FILE run --rm --network=status-page_default app pytest ./unit-testing/test_script.py

# Stop and remove the Docker Compose services
docker-compose -f $DOCKER_COMPOSE_FILE down
