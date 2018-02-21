#!/bin/bash


# we have run download-playlist.sh in $PLAYLIST_DIR
# we have segmented each video in the playlist
# there is a thumbnail for each downloaded video

PLAYLIST_DIR="$1"
NAME="$2"

NAME=$(basename $PLAYLIST_DIR)
PAGE_IDX=$(expr 1000 + `ls -l md-pages/playlist-*.md | wc -l`)

cat <<EOM
{:title "$NAME"

:page-index $PAGE_IDX
:layout :playlist


:playlist-items [
EOM


VIDEOS=$( find $PLAYLIST_DIR -maxdepth 1 -type f -name *.mp4 \
  | xargs -n1 basename -s .mp4 )

#echo $VIDEOS | xargs -n1 echo "VID"

for vid in $VIDEOS; do
  cat <<EOM
    {:video-thumbnail-url "/media/videos/${NAME}/${vid}.jpg"
	  :video-url "/media/videos/${NAME}/${vid}.hls/out.m3u8"
	  :title "${vid}"
	  :url "/video-${vid}.html"}
EOM
  
done


echo "]}"

#sed -e 's/^/https:\/\/tinydatacenter\.com\//' | xargs -n1 curl -o /dev/null