FROM ubuntu:18.04

# Environment variables
ENV SPARK_VERSION=2.4.0 \
	HADOOP_VERSION=2.7 \
	SPARK_HOME=/spark \
	PATH=$SPARK_HOME/bin:$PATH \
	PYSPARK_PYTHON=/usr/bin/python3



 #Install required apt package and ensure that the packages were installed
RUN apt-get update && apt-get install -y \
	bc \
	curl \
	openjdk-8-jdk \
	git \
	python3 \
	python3-pip \
	scala


# Install spark
RUN mkdir spark &&\
	curl -sL \
	http://ftp.tsukuba.wide.ad.jp/software/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
	| tar zx -C spark --strip-components 1


# install pip someting 4 notebook
RUN pip3 install jupyter && \
	pip3 install pandas && \
	pip3 install ipyparallel \
	&& ipcluster nbextension enable


COPY src/ /



WORKDIR /work/


