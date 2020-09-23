#!/usr/bin/env nextflow

nextflow.enable.dsl=2

if (params.fasta) {
    input_query_fasta = Channel.fromPath(params.fasta)
} else {
    input_query_fasta = Channel.fromPath("data/*.fna.gz")
}
input_target_fasta = Channel.fromPath('data/target/target.fna.gz')

process SEARCH {

    container 'mhoelzer/sourmash:3.5.0'

    input: 
    tuple path(query), path(target)

    output:
    path("${query.simpleName}")

    script:
    """
    sourmash compute -k 31 ${query} ${target}
    sourmash compare -k 31 *.sig -o ${query.simpleName}
    """
}

workflow {
    SEARCH(input_query_fasta.combine(input_target_fasta))
}