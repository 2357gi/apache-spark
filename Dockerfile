FROM ubuntu:18.04

# Environment variables
ENV SPARK_VERSION=2.4.0 \
	HADOOP_VERSION=2.7


# Install required apt package and ensure that the packages were installed
RUN apt-get update && apt-get install -y \
	bc \
	curl \
	default-jdk \
	git \
	scala


RUN mkdir spark \
    && curl -sL http://ftp.meisei-u.ac.jp/mirror/apache/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    | tar zx -C spark  --strip-components 1


EXPOSE 8080

