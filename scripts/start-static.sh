#!/bin/bash

source scripts/env.sh


docker run -d --restart always  \
  --name $NAME_STATIC \
  -v $ISPOOGE_MEDIA_PATH:/tmp/http/media:ro \
  -v /tmp/hls/ispooge.com:/tmp/http/hls:ro \
  -p $STATIC_PORT:9090 \
  $IMAGE_STATIC
