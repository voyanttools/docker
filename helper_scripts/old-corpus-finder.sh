#!/bin/bash

# Cutoff (older than this is returned)
now=$(date +%s)
days=${1:-365} # default is 365 days
cutoff=$(echo "$now - ($days * 24 * 60 * 60)" | bc)

# Directory to search
directory="/data/trombone5_2/cache"

# Pattern to match
pattern="cache-ToolRunner-*-CorpusMetadata*-*-*"

# Array to store matching files
matching_files=()

# Find files matching the pattern and store them in the array
while IFS= read -r -d '' file; do
    matching_files+=("$file")
done < <(find "$directory" -type f -name "$pattern" -print0)

declare -A corpus_times=()

# Populate array with most recent access times for each corpus
for file in "${matching_files[@]}"; do
    access_time=$(stat -c %X "$file") # file access time
    corpus_id=$(echo "$file" | sed -n -r -e "s/^.*cache-ToolRunner-.*-CorpusMetadata.*-([[:alnum:]]+)-.*$/\1/p") # extract corpus ID from filename
    if [[ -v corpus_times["${corpus_id}"] ]]; then
        if [[ corpus_times["${corpus_id}"] -lt access_time ]]; then
            corpus_times["${corpus_id}"]=$access_time # use the most recent access time
        fi
    else
        corpus_times["${corpus_id}"]=$access_time
    fi
done

# Check all most recent access times against the cutoff time
for corpus_id in "${!corpus_times[@]}"; do
    if [[ corpus_times["${corpus_id}"] -lt cutoff ]]; then
#        echo "corpus: $corpus_id | last access: ${corpus_times[$corpus_id]}"
         echo "$corpus_id"
    fi
done

