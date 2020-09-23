FROM continuumio/miniconda3
#FROM ubuntu:xenial  
#FROM r-base

RUN apt update && apt install -y procps wget gzip && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN conda config --add channels conda-forge && \
	conda config --add channels bioconda && \
	conda config --add channels default

RUN conda install -y -c bioconda sourmash=3.5.0 && conda clean -a
