#!/bin/bash

source scripts/env.sh


docker run -d --restart always  \
  --name $NAME_STATIC \
  -v $PWD/../ispooge-media/dl3:/tmp/http/media/videos:ro \
  -p $STATIC_PORT:9090 \
  $IMAGE_STATIC