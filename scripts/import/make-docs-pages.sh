#!/bin/bash


DOCS_DIR="${1:-doc}"


DOC_FILES=$( find $DOCS_DIR -maxdepth 1 -type f -name '*.md' )

i=4000
for docFile in $DOC_FILES; do
  export PAGE_INDEX="$i"
  export IS_NAVBAR="false"
  baseName="$(basename -s .md $docFile)"
  pageFile="md-pages/doc-$baseName.md" # todo flatten
  
  title="Doc: ${baseName}"

  scripts/import/md-to-page.sh "$docFile" "$title" > "$pageFile"
  
  i=$(expr $i + 1)
done

