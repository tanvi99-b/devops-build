#!/bin/bash

# Define variables
KEY_PATH="/home/ubuntu/Keypair01.pem"
USER="ubuntu"
SERVER_IP="52.87.186.167"
PROJECT_DIR="/home/devops-build"

# SSH into the server and run the Docker Compose commands
ssh -t -i "$KEY_PATH" "$USER@$SERVER_IP" <<EOF
  echo "Changing directory to $PROJECT_DIR"
  cd "$PROJECT_DIR" || { echo "Directory $PROJECT_DIR does not exist"; exit 1; }
  echo "Running docker-compose down"
  sudo docker-compose down
  echo "Running docker-compose up -d"
  sudo docker-compose up -d
EOF

