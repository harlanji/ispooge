#!/bin/bash


# we have run download-playlist.sh in $PLAYLIST_DIR
# we have segmented each video in the playlist
# there is a thumbnail for each downloaded video

DOCS_DIR="${1:-doc}"


DOC_FILES=$( find $DOCS_DIR -maxdepth 1 -type f -name '*.md' )

i=4000
for docFile in $DOC_FILES; do
  export PAGE_INDEX="$i"
  baseName="$(basename -s .md $docFile)"
  pageFile="md-pages/doc-$baseName.md" # todo flatten
  
  title="Doc: ${baseName}"

  scripts/md-to-page.sh "$docFile" "$title" > "$pageFile"
  
  i=$(expr $i + 1)
done

