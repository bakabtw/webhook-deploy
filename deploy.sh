#!/usr/bin/env sh

# Checking ENV variables
if [ -z "$DOCKER_DIR" ]; then
    echo "DOCKER_DIR variable is not set"
fi

# Checking DOCKER_HOST
if [ -z "$DOCKER_HOST" ]; then
    echo "DOCKER_HOST variable is not set"
fi

# Checking existence of docker directory
if ! [ -d "$DOCKER_DIR" ]; then
  echo "$DOCKER_DIR does not exist"
fi

# Changing dir
cd "$DOCKER_DIR" || exit

# Pulling updates from git repository
# git pull

# Pulling docker images
docker-compose -H "tcp://$DOCKER_HOST" pull

# Restarting updated containers
docker-compose -H "tcp://$DOCKER_HOST" up -d
