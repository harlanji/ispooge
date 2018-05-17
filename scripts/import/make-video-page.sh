#!/bin/bash

VIDEO_BASENAME="$1"
PLAYLIST_NAME="$2"

VIDEO="$VIDEO_BASENAME.mp4"
THUMBNAIL="$VIDEO_BASENAME.jpg"
HLS="$VIDEO_BASENAME.hls"

read -r -d '' PAGE_MD << EOM
{:title "Video $VIDEO_BASENAME"
 :layout :video
 :tags ["video" "playlist-$PLAYLIST_NAME"]
 :video-thumbnail-url "/media/videos/$PLAYLIST_NAME/$THUMBNAIL"
 :video-url "/media/videos/$PLAYLIST_NAME/$HLS/out.m3u8"
 :video-description "$VIDEO_BASENAME"
 }
EOM

echo $PAGE_MD
