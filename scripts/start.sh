#!/bin/bash

source scripts/env.sh

docker run -d --restart always \
--mount type=bind,source=$PWD/app,target=/tmp/app \
--name $NAME -p $DEV_PORT:3000 \
$IMAGE
