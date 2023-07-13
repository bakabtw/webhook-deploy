#!/usr/bin/env bash

# Checking ENV variables
if [ -z "$DOCKER_DIR" ]; then
    echo "DOCKER_DIR variable is not set"
fi

# Checking existence of docker directory
if ! [ -d "$DOCKER_DIR" ]; then
  echo "$DOCKER_DIR does not exist"
fi

# Changing dir
cd "$DOCKER_DIR" || exit

# Pulling updates from git repository
git pull

# Pulling docker images
docker-compose pull

# Restarting updated containers
docker-compose up -d
