#!/bin/bash

source scripts/env.sh

docker run -d --restart unless-stopped  \
  --name $NAME_STREAMING \
  -h ispooge-streaming \
  -v /tmp/hls:/tmp/hls \
  -p 33935:1935 \
  -p 33936:1936 \
  --link $NAME_STATIC \
  $IMAGE_STREAMING
