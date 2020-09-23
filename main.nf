#!/usr/bin/env nextflow

nextflow.enable.dsl=2

input_query_fasta = Channel.fromPath("data/*.fasta")
input_target_fasta = Channel.fromPath("data/target.fasta")

process SEARCH {

    container = 'mhoelzer/sourmash:3.5.0'

    input: 
    path(query)
    path(target)

    output:
    path("${query.simpleName}")

    script:
    """
    sourmash compute -k 31 ${query} ${target}
    sourmash compare -k 31 *.sig -o ${query.simpleName}
    """
}


workflow {
    SEARCH(input_query_fasta, input_target_fasta)
}