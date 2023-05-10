# This Makefile contains useful targets that can be included in downstream projects.

ifeq ($(filter adore_if_ros_msg.mk, $(notdir $(MAKEFILE_LIST))), adore_if_ros_msg.mk)

MAKEFLAGS += --no-print-directory

.EXPORT_ALL_VARIABLES:
ADORE_IF_ROS_MSG_PROJECT=adore_if_ros_msg

ADORE_IF_ROS_MSG_MAKEFILE_PATH:=$(shell realpath "$(shell dirname "$(lastword $(MAKEFILE_LIST))")")
ifeq ($(SUBMODULES_PATH),)
    ADORE_IF_ROS_MSG_SUBMODULES_PATH:=${ADORE_IF_ROS_MSG_MAKEFILE_PATH}
else
    ADORE_IF_ROS_MSG_SUBMODULES_PATH:=$(shell realpath ${SUBMODULES_PATH})
endif
MAKE_GADGETS_PATH:=${ADORE_IF_ROS_MSG_SUBMODULES_PATH}/make_gadgets
ifeq ($(wildcard $(MAKE_GADGETS_PATH)/*),)
    $(info INFO: To clone submodules use: 'git submodules update --init --recursive')
    $(info INFO: To specify alternative path for submodules use: SUBMODULES_PATH="<path to submodules>" make build')
    $(info INFO: Default submodule path is: ${ADORE_IF_ROS_MSG_MAKEFILE_PATH}')
    $(error "ERROR: ${MAKE_GADGETS_PATH} does not exist. Did you clone the submodules?")
endif
REPO_DIRECTORY:=${ADORE_IF_ROS_MSG_MAKEFILE_PATH}

ADORE_IF_ROS_MSG_TAG:=$(shell cd ${MAKE_GADGETS_PATH} && make get_sanitized_branch_name REPO_DIRECTORY=${REPO_DIRECTORY})

ADORE_IF_ROS_MSG_IMAGE=${ADORE_IF_ROS_MSG_PROJECT}:${ADORE_IF_ROS_MSG_TAG}

ADORE_IF_ROS_MSG_CMAKE_BUILD_PATH="${ADORE_IF_ROS_MSG_PROJECT}/build"
ADORE_IF_ROS_MSG_CMAKE_INSTALL_PATH="${ADORE_IF_ROS_MSG_CMAKE_BUILD_PATH}/install"

include ${MAKE_GADGETS_PATH}/make_gadgets.mk
include ${MAKE_GADGETS_PATH}/docker/docker-tools.mk

.PHONY: build_adore_if_ros_msg 
build_adore_if_ros_msg: ## Build adore_if_ros_msg
	cd "${ADORE_IF_ROS_MSG_MAKEFILE_PATH}" && make

.PHONY: clean_adore_if_ros_msg
clean_adore_if_ros_msg: ## Clean adore_if_ros_msg build artifacts
	cd "${ADORE_IF_ROS_MSG_MAKEFILE_PATH}" && make clean

.PHONY: branch_adore_if_ros_msg
branch_adore_if_ros_msg: ## Returns the current docker safe/sanitized branch for adore_if_ros_msg
	@printf "%s\n" ${ADORE_IF_ROS_MSG_TAG}

.PHONY: image_adore_if_ros_msg
image_adore_if_ros_msg: ## Returns the current docker image name for adore_if_ros_msg
	@printf "%s\n" ${ADORE_IF_ROS_MSG_IMAGE}

.PHONY: update_adore_if_ros_msg
update_adore_if_ros_msg:
	cd "${ADORE_IF_ROS_MSG_MAKEFILE_PATH}" && git pull

endif
