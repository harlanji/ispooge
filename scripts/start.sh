#!/bin/bash

source scripts/env.sh

docker run -d --restart always \
-v $PWD/app:/tmp/app \
-v "$ISPOOGE_MEDIA_PATH:/tmp/app/resources/public/media:ro" \
-v "/tmp/hls/ispooge.com:/tmp/app/resources/public/hls:ro" \
--name $NAME -p $DEV_PORT:3000 \
$IMAGE
