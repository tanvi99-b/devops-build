#!/bin/bash

# Define variables
IMAGE_NAME="devops-build-app"
REMOTE_HOST="your_remote_host"
REMOTE_USER="your_remote_user"
REMOTE_DIR="path_to_remote_directory"

# Load Docker image into a tar archive
echo "Saving Docker image to tar archive..."
docker save -o image.tar $IMAGE_NAME

# Transfer the Docker image to the remote server
echo "Transferring Docker image to remote server..."
scp image.tar $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR

# SSH into the remote server and load the Docker image
echo "SSH into remote server and load Docker image..."
ssh $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_DIR && docker load -i image.tar"

# Cleanup
echo "Cleaning up..."
rm image.tar

echo "Deployment completed successfully."
