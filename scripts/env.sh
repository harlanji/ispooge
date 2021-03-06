#!/bin/bash

# use with source

#ISPOOGE_MEDIA_PATH="$HOME/ispooge-media"
ISPOOGE_MEDIA_PATH="$HOME/mnt/ispooge-media-aws/ispooge-media"

IMAGE=ispooge-build
# todo: IMAGE_DEV like STATIC
NAME=ispooge.com-build
DEV_PORT=33000
STATIC_PORT=33080

RTMP_PORT=33935
HTTP_PORT=33936


DOMAIN=ispooge.com
HOSTS=ispooge.com


NAME_STATIC=ispooge.com-static
IMAGE_STATIC=docker-registry.local:5000/ispooge.com/ispooge-static:28
IMAGE_STATIC_LOCAL=ispooge-static

NAME_STREAMING=ispooge.com-streaming
IMAGE_STREAMING=docker-registry.local:5000/ispooge.com/ispooge-streaming:5
IMAGE_STREAMING_LOCAL=ispooge-streaming

if [ -f scripts/env-local.sh ]; then
  source scripts/env-local.sh
fi
