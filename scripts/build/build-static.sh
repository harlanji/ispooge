#!/bin/bash

source scripts/env.sh

docker build -t $IMAGE_STATIC_LOCAL -f scripts/docker/Dockerfile.static .
docker tag $IMAGE_STATIC_LOCAL $IMAGE_STATIC
