#!/bin/bash

trombone_dir="/data/trombone5_2"

doc_string=$(./get-documents-for-corpus.sh "${1}")

while IFS= read -r doc_id || [[ -n $doc_id ]]; do
    rm -rf "${trombone_dir}/stored_document_sources/${doc_id}"
done < <(printf '%s' "$doc_string")

rm -f "${trombone_dir}/object-storage/${1}-langs"
rm -f "${trombone_dir}/object-storage/${1}-lexicalLastTokenPositions"
rm -f "${trombone_dir}/object-storage/${1}-lexicalTokenCounts"
rm -f "${trombone_dir}/object-storage/${1}-lexicalTypesCountMeans-1"
rm -f "${trombone_dir}/object-storage/${1}-lexicalTypesCountStdDevs-1"
rm -f "${trombone_dir}/object-storage/mapdb-${1}-corpusTermMinimals-lexical"
rm -f "${trombone_dir}/object-storage/mapdb-${1}-corpusTermMinimals-lexical.p"
rm -f "${trombone_dir}/object-storage/${1}"

rm -rf "${trombone_dir}/lucene-per-corpus/${1}"

rm -rf "${trombone_dir}/corpora/${1}"

