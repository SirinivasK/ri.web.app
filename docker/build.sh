#!/bin/bash

# Build the Docker image using BuildKit
DOCKER_BUILDKIT=1 docker build -t node-js-app-image .
