#!/bin/bash

trombone_dir="/data/trombone5_2"

corpus_id="${1}"

docs_file="${trombone_dir}/object-storage/${corpus_id}"

cat "${docs_file}"
