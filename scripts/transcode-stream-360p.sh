#!/bin/bash

./ffmpeg -hide_banner -y -codec:v h264_mmal \
  -i rtmp://localhost:33935/ispoogedaily_source/ispoogedaily_360 \
  -c:a copy -c:v h264 -profile:v main -sc_threshold 0 -g 60 -keyint_min 50 \
  -vf scale=w=640:h=360:force_original_aspect_ratio=decrease \
  -b:v 3000k -maxrate 3210k -bufsize 32100k \
  -f flv rtmp://localhost:33935/ispoogedaily_local/ispoogedaily_360