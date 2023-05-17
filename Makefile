SHELL:=/bin/bash

.DEFAULT_GOAL := all

ROOT_DIR:=$(shell dirname "$(realpath $(firstword $(MAKEFILE_LIST)))")

include adore_if_ros_msg.mk

MAKEFLAGS += --no-print-directory


.EXPORT_ALL_VARIABLES:
DOCKER_BUILDKIT?=1
DOCKER_CONFIG?=

SUBMODULES_PATH?=${ROOT_DIR}

include ${SUBMODULES_PATH}/ci_teststand/ci_teststand.mk

.PHONY: all
all: build

.PHONY: build
build: clean root_check docker_group_check _build ## Build adore_if_ros_msg


.PHONY: set_env 
set_env:
	$(eval PROJECT := ${ADORE_IF_ROS_MSG_PROJECT}) 
	$(eval TAG := ${ADORE_IF_ROS_MSG_TAG})

.PHONY: _build
_build: set_env 
	docker build --network host \
                 --tag ${PROJECT}:${TAG} \
                 --build-arg PROJECT=${PROJECT} .
	docker cp $$(docker create --rm ${PROJECT}:${TAG}):/tmp/${PROJECT}/${PROJECT}/build "${ROOT_DIR}/${PROJECT}"

.PHONY: clean
clean: set_env ## Clean adore_if_ros_msg build artifacts 
	rm -rf "${ROOT_DIR}/${PROJECT}/build"
	docker rm $$(docker ps -a -q --filter "ancestor=${PROJECT}:${TAG}") --force 2> /dev/null || true
	docker rmi $$(docker images -q ${PROJECT}:${TAG}) --force 2> /dev/null || true

.PHONY: _docker_save
_docker_save: set_env
	@docker save --output "${ROOT_DIR}/${PROJECT}/build/${PROJECT}_${TAG}.tar" ${PROJECT}:${TAG} 

.PHONY: _docker_load
_docker_load: set_env
	@docker load --input "${ROOT_DIR}/${PROJECT}/build/${PROJECT}_${TAG}.tar" 

.PHONY: test
test: ci_test
