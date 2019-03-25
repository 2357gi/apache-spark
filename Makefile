WORKER=1
PYFILE=pythonファイルを指定してください

build_docker: Dockerfile
	@echo "\n📦 build 2357gi/apache-spark"
	@docker build ./ -t 2357gi/apache-spark

build_compose:
	@echo "\n🏗  Pile up containers"
	@docker-compose up -d --scale worker=$(WORKER)

run: docker-compose.yml
	@echo "\n✨ apache-spark cluster setup is start!"
	@make build_docker
	@make build_compose
	@echo "\n🍾 set up is finished! \n you wanna access ⚡spaek shell, hit it! \n$$ make  s-shell"
	@echo "or you wanna start 📔 pyspark notebook, hit it! \n$$ make notebook"
	@echo "... if u wanna open 🐚 shell? do this. \n$$ make shell"

s-shell:
	@echo "\n⚡ start spark-shell...."
	@docker-compose exec master /spark/bin/spark-shell --master spark://localhost:7077

notebook:
	@echo "\n📔 start pyspark notebook...."
	@docker-compose exec master /spark/bin/pyspark
	@docker-compose exec

shell:
	@echo "\n🐚 start master shell...."
	@docker-compose exec master /bin/bash


kick-py:
	@echo "\n 🎯 lets kick spark with py-file!"
	@echo "\n target .py is ${PYFILE}"
	@docker-compose exec master /spark/bin/spark-submit --py-files ${PYFILE} ${PYFILE}

