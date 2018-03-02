#!/bin/bash

# use with source

ISPOOGE_MEDIA_PATH="$HOME/ispooge-media"

IMAGE=ispooge-build
# todo: IMAGE_DEV like STATIC
NAME=ispooge.com-build
DEV_PORT=33000
STATIC_PORT=33080


DOMAIN=ispooge.com
HOSTS=ispooge.com


NAME_STATIC=ispooge.com-static
IMAGE_STATIC=docker-registry.local:5000/ispooge.com/ispooge-static:7
IMAGE_STATIC_LOCAL=ispooge-static
