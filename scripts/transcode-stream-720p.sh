#!/bin/bash

./ffmpeg -hide_banner -y -codec:v h264_mmal \
  -i rtmp://localhost:33935/ispoogedaily_source/ispoogedaily_720 \
  -c:a copy -c:v h264 -profile:v main -sc_threshold 0 -g 60 -keyint_min 50 \
  -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease \
  -b:v 6000k -maxrate 6420k -bufsize 64200k \
  -f flv rtmp://localhost:33935/ispoogedaily_local/ispoogedaily_720
