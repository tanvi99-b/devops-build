#!/bin/bash

# Define variables
IMAGE_NAME="devops-build-app"
DOCKERFILE_PATH="./Dockerfile"

# Build Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME -f $DOCKERFILE_PATH .

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "Docker image built successfully."
else
  echo "Failed to build Docker image."
  exit 1
fi
