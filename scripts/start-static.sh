#!/bin/bash

source scripts/env.sh


docker run -d --restart always  \
  --name $NAME_STATIC \
  -h ispooge-static \
  -v $ISPOOGE_MEDIA_PATH:/tmp/http/media:ro \
  -p $STATIC_PORT:9090 \
  $IMAGE_STATIC
