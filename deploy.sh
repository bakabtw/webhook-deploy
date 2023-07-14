#!/usr/bin/env sh

SSH_KEY_FILE=/run/secrets/ssh_key

# Checking ENV variables
if [ -z "$DOCKER_DIR" ]; then
    echo "DOCKER_DIR variable is not set"
    exit
fi

if [ -z "$SSH_HOST" ] || [ -z "$SSH_PORT" ] || [ -z "$SSH_USERNAME" ]; then
    echo "SSH credentials are not fully provided. You should provide SSH_HOST, SSH_PORT, SSH_USERNAME"
    exit
fi

# Checking presence of SSH_KEY secret
if ! [ -f "$SSH_KEY_FILE" ]; then
    echo "SSH_KEY secret does not exist. Please create a secret:"
    echo "printf \"This is a secret\" | docker secret create ssh_key -"
    exit
fi

# Connecting via SSH to remote server
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_FILE" "$SSH_USERNAME"@"$SSH_HOST" -p"$SSH_PORT" << EOF
if ! [ -d "$DOCKER_DIR" ]; then
  echo "$DOCKER_DIR does not exist"
  exit
fi

cd "$DOCKER_DIR" || exit

docker-compose pull
docker-compose up -d
EOF
