#!/bin/bash

# copy a markdown file to md-pages with a flattened filename 
# and a header.

FILE="$1"
TITLE="${2:-$FILE}"
LAYOUT="${LAYOUT:-:page}"
PAGE_INDEX="${PAGE_INDEX:-4000}"
IS_NAVBAR="${IS_NAVBAR:-true}"
GENERATED_AT="${GENERATED_AT:-$(date +%s)}"
LAST_MODIFIED="${LAST_MODIFIED:-$(stat -c %Y $FILE)}"

cat <<HEADER_META
{:layout $LAYOUT
 :title "$TITLE"
 :page-index $PAGE_INDEX
 :navbar? $IS_NAVBAR
 :generated-at $GENERATED_AT
 :last-modified $LAST_MODIFIED
 }

HEADER_META

cat $FILE