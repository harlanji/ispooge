#!/bin/bash

docker run -d --restart always  --name website-v2-static-prod -p 80:9090 \
--mount type=bind,source=$HOME/media,target=/tmp/http/media,readonly \
website-v2-static
