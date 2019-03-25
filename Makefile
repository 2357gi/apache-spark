PYFILE=正しくPYFILEを設定してください

build_docker: Dockerfile
	@echo "\n📦 build 2357gi/apache-spark"
	@docker build ./ -t 2357gi/apache-spark

build_compose:
	@echo "\n🏗  Pile up containers"
	@docker-compose up -d

run: docker-compose.yml
	@echo "\n✨ apache-spark cluster setup is start!"
	@make build_docker
	@make build_compose
	@echo "\n🍾 set up is finished! \n you wanna access ⚡spaek shell, hit it! \n$$ make  s-shell"
	@echo "or you wanna start 📔 pyspark notebook, hit it! \n$$ make notebook"
	@echo "... if u wanna open 🐚 shell? do this. \n$$ make shell"
	@echo "\n or u have python file and wanna kickin spark with this, \n $$make kick-py PYFILE=<pythonfille>"
s-shell:
	@echo "\n⚡ start spark-shell...."
	@docker-compose exec master /spark/bin/spark-shell --master spark://master:7077

notebook:
	@echo "\n📔 start pyspark notebook...."
	@docker-compose exec master /spark/bin/pyspark --master spark://master:7077
	@docker-compose exec

shell:
	@echo "\n🐚 start master shell...."
	@docker-compose exec master /bin/bash


setup-jpnb:
	@echo "\n ⚡ pull jupyter/pyspark-notebook"
	@docker pull jupyter/pyspark-notebook

start-jpnb:
	@echo "\n ⚡ start docker notebook"
	@docker run -p 8888:8888 -v $(pwd)/work:/home/jovyan/work jupyter/pyspark-notebook start-notebook.sh

kick-py:
	@echo "\n 🎯 lets kick spark with py-file!"
	@echo "\n target .py is ${PYFILE}"
	@docker-compose exec master /spark/bin/spark-submit --py-files ${PYFILE} ${PYFILE}


