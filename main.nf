#!/usr/bin/env nextflow

nextflow.enable.dsl=2

input_query_fasta = Channel.fromPath("data/GCF_000693535.1_Kleb_pneu_CHS_28_V1_genomic.fna.gz")
//input_query_fasta = Channel.fromPath('data/*.fna.gz')
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