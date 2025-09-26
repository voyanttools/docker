#!/bin/bash

trombone_dir="/voyant-data/trombone5_2/"
modded_corpora_file="modded/modded_${1/subsets\//}"

delete_corpus_id () {
  # check if its a modified corpus and if so, skip it
  params_file="${trombone_dir}/corpora/${1}/parameters.xml"
  if [[ -f $params_file ]]; then
    is_it_modded=$(grep $params_file -e 'nextCorpusCreatorStep')
    if [[ $is_it_modded ]]; then
      echo $1 >> $modded_corpora_file
      return 0
    fi
  fi

  lang_file="${trombone_dir}/object-storage/${1}-langs"
  if [[ -f $lang_file ]]; then
    # Remove the documents file
    docs_file="${trombone_dir}/object-storage/${1}"
    if [[ -f $docs_file  ]]; then
      while IFS= read -r doc_id || [[ -n $doc_id ]]; do
          rm -rf "${trombone_dir}/stored_document_sources/${doc_id}"
      done < "${docs_file}"

      rm -f "$docs_file"
    fi

    # Remove all other files
    rm -f "${trombone_dir}/object-storage/${1}-lexicalLastTokenPositions"
    rm -f "${trombone_dir}/object-storage/${1}-lexicalTokenCounts"
    rm -f "${trombone_dir}/object-storage/${1}-lexicalTypesCountMeans-1"
    rm -f "${trombone_dir}/object-storage/${1}-lexicalTypesCountStdDevs-1"
    rm -f "${trombone_dir}/object-storage/mapdb-${1}-corpusTermMinimals-lexical"
    rm -f "${trombone_dir}/object-storage/mapdb-${1}-corpusTermMinimals-lexical.p"
    rm -rf "${trombone_dir}/lucene-per-corpus/${1}"
    rm -rf "${trombone_dir}/corpora/${1}"

    # Finally, delete the langs file last.
    rm -f "$lang_file"
  fi
}

while read -r corpus_iden; do
  delete_corpus_id "$corpus_iden"
done < "$1"