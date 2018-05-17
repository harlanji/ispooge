#!/bin/bash

PLAYLIST_ID=${1:-"PLD5lYPY-uZpq7x2zRIiULo2oZ-tWs2lPx"}
NAME=${2:-"Random"}


TINYDC=$HOME/tinydatacenter
ISPOOGE=$TINYDC/ispooge.com-v2
ISPOOGE_MEDIA=$HOME/ispooge-media

PLAYLIST=$ISPOOGE_MEDIA/videos/$NAME

echo "Playlist: $PLAYLIST"

mkdir -p $PLAYLIST
cd $PLAYLIST


#$ISPOOGE/scripts/import/download-playlist.sh $PLAYLIST_ID

ls -la

VIDEOS=$( find $PLAYLIST -maxdepth 1 -type d -name "*.hls" \
  | xargs -n1 basename -s ".hls" )



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
    #$ISPOOGE/scripts/segment-video.sh $vid_file
  fi  
    
  cd $ISPOOGE
  pdate=`date +%Y-%m-%d` # todo get from video metadata
  scripts/import/make-video-page.sh $vid $NAME > "md-posts/${pdate}-video-${vid}.md" 
done

cd $ISPOOGE
pdate=`date +%Y-%m-%d` # todo get from playlist metadata
scripts/import/make-playlist-page.sh $PLAYLIST $NAME > "md-posts/${pdate}-playlist-${NAME}.md"
