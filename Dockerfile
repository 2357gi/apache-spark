FROM ubuntu:18.04

ENV SPARK_VERSION=2.4.0 \
	HADOOP_VERSION=2.7

RUN apt-get update && apt-get install -y \
	bc \
	curl \
	default-jdk \
	git \
	scala

WORKDIR /work

ADD http://ftp.meisei-u.ac.jp/mirror/apache/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz /spark.tgz
ADD spark.tgz /

EXPOSE 8080

