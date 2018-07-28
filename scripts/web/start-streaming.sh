#!/bin/bash

source scripts/env.sh

docker run -d --restart unless-stopped  \
  --name $NAME_STREAMING \
  -h ispooge-streaming \
  -v $PWD/nginx-conf:/etc/nginx:ro \
  -v $ISPOOGE_MEDIA_PATH/hls:/tmp/http/hls:rw \
  -v $ISPOOGE_MEDIA_PATH:/tmp/http/media:ro \
  -v $PWD/app/resources/public:/tmp/http/cryogen:ro \
  -p $RTMP_PORT:1935 \
  -p $HTTP_PORT:1936 \
  $IMAGE_STREAMING
