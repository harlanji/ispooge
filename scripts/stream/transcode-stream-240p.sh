#!/bin/bash

./ffmpeg -hide_banner -y -codec:v h264_mmal \
  -i rtmp://localhost:33935/ispoogedaily_source/ispoogedaily_240 \
  -c:a copy -c:v h264 -profile:v main -sc_threshold 0 -g 60 -keyint_min 50 \
  -vf scale=w=426:h=240:force_original_aspect_ratio=decrease \
  -b:v 800k -maxrate 1000k -bufsize 10000k \
  -f flv rtmp://localhost:33935/ispoogedaily_local/ispoogedaily_240