FROM ubuntu:18.04

MAINTAINER Louise Cabansay <lcabansa@ucsc.edu>

RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y \
	wget build-essential libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev


WORKDIR /usr/src

#Samtools
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
	tar xjf samtools-1.10.tar.bz2 && \
	rm samtools-1.10.tar.bz2 && \
	cd samtools-1.10 && \
	./configure --prefix $(pwd) && \
	make

ENV PATH="/usr/src/samtools-1.10:${PATH}"