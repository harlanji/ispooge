#!/bin/bash

source scripts/env.sh


docker run -d --restart always  \
  --name $NAME_STATIC \
  -v $ISPOOGE_MEDIA_PATH:/tmp/http/media/videos:ro \
  -p $STATIC_PORT:9090 \
  $IMAGE_STATIC