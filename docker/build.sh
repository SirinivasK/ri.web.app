#!/bin/bash

# Build the Docker image using BuildKit
DOCKER_BUILDKIT=1 docker build -t your-node-app-image .

# If you have a caching mechanism, consider using cache for faster builds
# DOCKER_BUILDKIT=1 docker build --target builder -t your-node-app-builder .

# Clean up unused builder image
# docker image prune -f --filter label=stage=builder

# You can also use multi-stage builds to create a smaller final image
# See: https://docs.docker.com/develop/develop-images/multistage-build/
