#!/bin/bash

DATA_DIR="/data"
TROMBONE_DIR="${DATA_DIR}/trombone5_2"
CHECK_DIR="${TROMBONE_DIR}/object-storage"
CUTOFF_DATE=$(date -d "365 days ago" +%s)

# Declare an array to hold corpus IDs to be deleted
#corpus_ids=()

# Loop through all files ending with '-langs' in the specified directory
for file in "$CHECK_DIR"/*-langs; 
do
  if [[ -f $file ]]; then
    # Extract corpus ID from the filename
    corpus_id=$(basename "$file" | sed 's/-langs//')
    
    # Get the last access time of the file in seconds since epoch
    last_access_time=$(stat -c %X "$file")
    
    # Check if the file was accessed within the last 180 days
    if [[ $last_access_time -le $CUTOFF_DATE ]]; then
      # Convert the access time to human-readable format
      readable_access_time=$(date -d @$last_access_time)
      
      # Add the corpus ID to the array
      #corpus_ids+=("$corpus_id")
      echo "$corpus_id"
    fi
  fi
done
