#!/bin/bash

source scripts/env.sh

docker build -t $IMAGE_STREAMING -f Dockerfile.streaming .
