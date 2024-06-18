#!/bin/bash

# Set the image name and version
IMAGE_NAME="my-react-app"
IMAGE_VERSION="v1.0.0"

# Build the Docker image
docker build -t $IMAGE_NAME:$IMAGE_VERSION .
