FROM ubuntu:18.04

# Environment variables
ENV SPARK_VERSION=2.4.0 \
	HADOOP_VERSION=2.7 \
	SPARK_HOME=/spark \
	PATH=$SPARK_HOME/bin:$PATH \
	PYSPARK_PYTHON=/usr/bin/python3 \
	PYSPARK_DRIVER_PYTHON=/usr/local/bin/jupyter \
	PYSPARK_DRIVER_PYTHON_OPTS="notebook --no-browser --port 8888 --ip=0.0.0.0 --allow-root"



 #Install required apt package and ensure that the packages were installed
# デバッグ中に付き一つずつinstallしてあるので最後に纏める
RUN apt-get update && apt-get install -y \
	bc \
	curl \
	default-jdk \
	git \
	python3 \
	scala

RUN apt-get install -y 	python3-pip


# Install spark
RUN mkdir spark &&\
	curl -sL \
	http://ftp.tsukuba.wide.ad.jp/software/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
	| tar zx -C spark --strip-components 1


RUN pip3 install jupyter
RUN pip3 install ipyparallel \
	&& ipcluster nbextension enable


# COPY src/ /


# sparkのnode接続用port
EXPOSE 8080

# sparkのwebUI用のport
EXPOSE 4040

# jupyter notebook用のport
EXPOSE 8888


