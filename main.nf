#!/usr/bin/env nextflow

nextflow.enable.dsl=2

input_fasta_channel = Channel.fromPath("data/*.fasta")

process ALIGN {

    input: 
    path(fastas)
    path(db)

    output:
    path("${fastas.simpleName}.m8")

    script:
    """
    mmseqs easy-search ${fastas} ${db} ${fastas.simpleName}.m8 tmp
    """
}

process DATABASE {

    output: 
    path('uniprot_sprot.tar.gz')

    script:
    """
    wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz .
    mmseqs createdb uniprot_sprot.fasta.gz targetDB
    mmseqs createindex targetDB tmp
    tar zcvf uniprot_sprot.tar.gz target*
    """
}

workflow {
    DATABASE()
    ALIGN(input_fasta_channel, DATABASE.out)
}