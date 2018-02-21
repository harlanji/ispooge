#!/bin/bash

VIDEO_BASENAME="$1"
PLAYLIST_NAME="$2"

VIDEO="$VIDEO_BASENAME.mp4"
THUMBNAIL="$VIDEO_BASENAME.jpg"
HLS="$VIDEO_BASENAME.hls"
PAGE="md-pages/video-$VIDEO_BASENAME.md"

PAGE_IDX=$(expr 5000 + `ls -l md-pages/video-*.md | wc -l`)

read -r -d '' PAGE_MD << EOM
{:title "Video $VIDEO_BASENAME"
 :page-index $PAGE_IDX
 :layout :video
 :video-thumbnail-url "/media/videos/$PLAYLIST_NAME/$THUMBNAIL"
 :video-url "/media/videos/$PLAYLIST_NAME/$HLS/out.m3u8"
 :video-description "$VIDEO_BASENAME"
 }
EOM


PAGE="md-pages/video-$1.md"


echo $PAGE_MD
