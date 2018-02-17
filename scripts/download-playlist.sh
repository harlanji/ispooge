PLAYLIST="PLD5lYPY-uZpq7x2zRIiULo2oZ-tWs2lPx"



youtube-dl \
  --verbose \
  --add-metadata \
  --no-mark-watched \
  --yes-playlist \
  --write-all-thumbnails \
  --all-subs \
  --no-call-home \
  --restrict-filenames \
  "https://www.youtube.com/playlist?list=$PLAYLIST"
