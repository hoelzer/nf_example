process SEARCH {

    //container 'mhoelzer/sourmash:4.8.10'

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
