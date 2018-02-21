#!/bin/bash

PLAYLIST=$1

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
