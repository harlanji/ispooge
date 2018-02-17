PLAYLIST=${1:"PLD5lYPY-uZpq7x2zRIiULo2oZ-tWs2lPx"}
NAME=${2:"Random"}

scripts/download-playlist.sh $PLAYLIST

VIDEOS=$( find $PLAYLIST_DIR -maxdepth 1 -type f -name *.mp4 \
  | xargs -n1 basename -s .mp4 )


for vid in $VIDEOS; do
  scripts/segment-video.sh $vid
  scripts/make-video-page $vid > 
done

scripts/make-playlist-page.sh . > playlist-$NAME.md
