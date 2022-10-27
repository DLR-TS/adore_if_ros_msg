SHELL:=/bin/bash

.DEFAULT_GOAL := all

ROOT_DIR:=$(shell dirname "$(realpath $(firstword $(MAKEFILE_LIST)))")
MAKEFILE_PATH:=$(shell dirname "$(abspath "$(lastword $(MAKEFILE_LIST)"))")


include make_gadgets/make_gadgets.mk
include make_gadgets/docker/docker-tools.mk
include adore_if_ros_msg.mk


REPO_DIRECTORY="${MAKEFILE_PATH}"
TAG="$(shell cd make_gadgets && make get_sanitized_branch_name REPO_DIRECTORY=${REPO_DIRECTORY})"

ADORE_IF_ROS_MSG_PROJECT="adore_if_ros_msg"
ADORE_IF_ROS_MSG_VERSION="latest"
#ADORE_IF_ROS_MSG_TAG="${ADORE_IF_ROS_MSG_PROJECT}:${ADORE_IF_ROS_MSG_VERSION}"
ADORE_IF_ROS_MSG_TAG="${ADORE_IF_ROS_MSG_PROJECT}:${TAG}"
adore_if_ros_msg_TAG="${ADORE_IF_ROS_MSG_TAG}"


.EXPORT_ALL_VARIABLES:
DOCKER_BUILDKIT?=1
DOCKER_CONFIG?=

.PHONY: all
all: build

.PHONY: set_env 
set_env: 
	$(eval PROJECT := ${ADORE_IF_ROS_MSG_PROJECT}) 
	$(eval TAG := ${ADORE_IF_ROS_MSG_TAG})

.PHONY: build 
build: root_check docker_group_check set_env clean ## Build adore_if_ros_msg 
	docker build --network host \
                 --tag $(shell echo ${TAG} | tr A-Z a-z) \
                 --build-arg PROJECT=${PROJECT} .
	docker cp $$(docker create --rm $$(echo ${TAG} | tr A-Z a-z)):/tmp/${PROJECT}/build "${ROOT_DIR}/${PROJECT}"

.PHONY: clean
clean: set_env ## Clean adore_if_ros_msg build artifacts 
	rm -rf "${ROOT_DIR}/${PROJECT}/build"
	docker rm $$(docker ps -a -q --filter "ancestor=${TAG}") 2> /dev/null || true
	docker rmi $$(docker images -q ${PROJECT}) 2> /dev/null || true

.PHONY: build_docker_layers 
build_docker_layers: 
	@DOCKER_BUILDKIT=0 make build #| grep "\-\-\->" | \
#                                       grep -v "Using" | \
#                                       sed "s| \-\-\-> ||g" | \
#                                       sed "s|Running in ||g" | \
#                                       tr '\n' ' ' >> .docker_layers_cache
#	@echo "($$(git rev-parse --abbrev-ref HEAD):$$(git rev-parse --short HEAD))" >> .docker_layers_cache
