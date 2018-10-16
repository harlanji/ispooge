#!/bin/bash

# copy a markdown file to md-pages with a flattened filename 
# and a header.

BIN_DATE=${BIN_DATE:-"date"}
BIN_STAT=${BIN_STAT:-"stat"}

FILE="$1"
TITLE="${2:-$FILE}"
LAYOUT="${LAYOUT:-:page}"
PAGE_INDEX="${PAGE_INDEX:-4000}"
IS_NAVBAR="${IS_NAVBAR:-true}"
GENERATED_AT="${GENERATED_AT:-$($BIN_DATE +%s)}"
LAST_MODIFIED="${LAST_MODIFIED:-$($BIN_STAT -c %Y $FILE)}"

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
