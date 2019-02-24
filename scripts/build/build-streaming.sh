#!/bin/bash

source scripts/env.sh

docker build -t $IMAGE_STREAMING -f scripts/docker/Dockerfile.streaming .
