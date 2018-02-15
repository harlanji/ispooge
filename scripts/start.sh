#!/bin/bash

source scripts/env.sh

docker run -d --restart always \
-v $PWD/app:/tmp/app \
-v $PWD/../ispooge-media/dl3:/tmp/app/resources/public/media/videos:ro \
--name $NAME -p $DEV_PORT:3000 \
$IMAGE
