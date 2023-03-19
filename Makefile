#----------------------------------------------------------------------------------------------------------------------
# Flags
#----------------------------------------------------------------------------------------------------------------------
SHELL:=/bin/bash
CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DOCKER_IMAGE_NAME=sound_classification_training_image
export DOCKER_BUILDKIT=1
#----------------------------------------------------------------------------------------------------------------------
# Targets
#----------------------------------------------------------------------------------------------------------------------
default: run 
.PHONY:  


docker_build:
	@$(call msg, Building Docker images ...)
	@docker-compose build
	
run: docker_build
	@$(call msg, Starting the application ...)
	@sudo chmod 777 -R ./grafana/data
	@xhost +
	@docker-compose down
	@docker-compose up -d prometheus grafana
	@docker-compose up customer_tracking 


#----------------------------------------------------------------------------------------------------------------------
# helper functions
#----------------------------------------------------------------------------------------------------------------------
define msg
	tput setaf 2 && \
	for i in $(shell seq 1 120 ); do echo -n "-"; done; echo  "" && \
	echo "         "$1 && \
	for i in $(shell seq 1 120 ); do echo -n "-"; done; echo "" && \
	tput sgr0
endef

