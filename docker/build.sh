#!/bin/bash

# Build the Docker image using BuildKit
DOCKER_BUILDKIT=1 docker build -t node-js-app-image .

# To use cache and build efficiently, consider using named build stages
# DOCKER_BUILDKIT=1 docker build -t node-js-app-image \
#     --target builder \
#     --cache-from node-js-app-image:builder \
#     --build-arg NODE_ENV=production \
#     .

# Cleanup unused images
# docker image prune -f --filter label=stage=builder