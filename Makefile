.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: ## Install everything
	./init/init_go.sh
	./init/init_docker.sh
	./init/init_java17.sh
	./init/init_azure.sh
	./init/init_aws.sh
	./init/init_gcp.sh
	./init/init_conda.sh

aws: ## Install AWS Cli
	./init/init_aws.sh

az: ## Install Azure Cli
	./init/init_azure.sh

conda: ## Install Miniconda for Python
	./init/init_conda.sh

docker: ## Install Docker and Docker Compose
	./init/init_docker.sh

gcp: ## InstLL GCP Cli
	./init/init_gcp.sh

git_log: ## Fancy git log
	git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all

go: ## Install Go
	./init/init_go.sh
	source ~/.profile

java: ## Install Java
	./init/init_java17.sh

microk8s_up: ## Setup Microk8s
	./init/microk8s_up.sh