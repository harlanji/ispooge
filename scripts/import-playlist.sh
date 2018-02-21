#!/bin/bash

PLAYLIST_ID=${1:-"PLD5lYPY-uZpq7x2zRIiULo2oZ-tWs2lPx"}
NAME=${2:-"Random"}


TINYDC=$HOME/p/tinydatacenter
ISPOOGE=$TINYDC/ispooge.com-v2
ISPOOGE_MEDIA=$TINYDC/ispooge-media

PLAYLIST=$ISPOOGE_MEDIA/videos/$NAME

echo "Playlist: $PLAYLIST"

mkdir -p $PLAYLIST
cd $PLAYLIST


$ISPOOGE/scripts/download-playlist.sh $PLAYLIST_ID

ls -la

VIDEOS=$( find $PLAYLIST -maxdepth 1 -type f -name "*.mp4" \
  | xargs -n1 basename -s .mp4 )

for vid in $VIDEOS; do
  cd $PLAYLIST
  hls="${PLAYLIST}/${vid}.hls" 
  echo "HLS: $hls"
  if [ ! -d $hls ]; then
    # delete .hls dir if it gets inturrupted
    
    vid_file="${PLAYLIST}/${vid}.mp4"
    echo "segment $hls / $vid_file"
  
    mkdir -p $hls
    cd $hls
    $ISPOOGE/scripts/segment-video.sh $vid_file
  fi  
    
  cd $ISPOOGE
  scripts/make-video-page.sh $vid $NAME > "md-pages/video-${vid}.md" 
done

cd $ISPOOGE
scripts/make-playlist-page.sh $PLAYLIST $NAME > "md-pages/playlist-${NAME}.md"
