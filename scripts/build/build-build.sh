#!/bin/bash

source scripts/env.sh

docker build -t $IMAGE -f scripts/docker/Dockerfile.build .
