#!/bin/bash

# This script shows the access times for the two file types we use to get corpus age.
# It is useful for comparing differences.

DATA_DIR="/data"
TROMBONE_DIR="${DATA_DIR}/trombone5_2"

CORPUS_ID=${1:?"missing corpus ID"}

LANG_FILE="${TROMBONE_DIR}/object-storage/${CORPUS_ID}-langs"

LANG_ACCESS_TIME=$(stat -c %X "$LANG_FILE")
echo "$LANG_FILE : $(date -d @$LANG_ACCESS_TIME)"

MD_PATTERN="cache-ToolRunner-*-CorpusMetadata*-$CORPUS_ID-*"

matching_files=()
while IFS= read -r -d '' file; do
    matching_files+=("$file")
done < <(find "${TROMBONE_DIR}/cache" -type f -name "$MD_PATTERN" -print0)

MD_TIME=99999999
MD_FILE=""
for file in "${matching_files[@]}"; do
    access_time=$(stat -c %X "$file")
    if [[ MD_TIME -lt access_time ]]; then
        MD_TIME=$access_time
        MD_FILE=$file
    fi
done

echo "$MD_FILE : $(date -d @$MD_TIME)"
