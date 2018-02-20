#!/bin/bash

VIDEO=${1:"DwWvl0M"}


youtube-dl \
  --verbose \
  --add-metadata \
  --no-mark-watched \
  --yes-playlist \
  --write-all-thumbnails \
  --all-subs \
  --no-call-home \
  --restrict-filenames \
  "https://www.youtube.com/watch?v=$VIDEO"
