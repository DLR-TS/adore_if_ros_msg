# This Makefile contains useful targets that can be included in downstream projects.

ifndef ADORE_IF_ROS_MSG_MAKEFILE_PATH

MAKEFLAGS += --no-print-directory

.EXPORT_ALL_VARIABLES:
ADORE_IF_ROS_MSG_PROJECT=adore_if_ros_msg

ADORE_IF_ROS_MSG_MAKEFILE_PATH:=$(shell realpath "$(shell dirname "$(lastword $(MAKEFILE_LIST))")")
MAKE_GADGETS_PATH:=${ADORE_IF_ROS_MSG_MAKEFILE_PATH}/make_gadgets
REPO_DIRECTORY:=${ADORE_IF_ROS_MSG_MAKEFILE_PATH}

ADORE_IF_ROS_MSG_TAG:=$(shell cd ${MAKE_GADGETS_PATH} && make get_sanitized_branch_name REPO_DIRECTORY=${REPO_DIRECTORY})

ADORE_IF_ROS_MSG_IMAGE=${ADORE_IF_ROS_MSG_PROJECT}:${ADORE_IF_ROS_MSG_TAG}

ADORE_IF_ROS_MSG_CMAKE_BUILD_PATH="${ADORE_IF_ROS_MSG_PROJECT}/build"
ADORE_IF_ROS_MSG_CMAKE_INSTALL_PATH="${ADORE_IF_ROS_MSG_CMAKE_BUILD_PATH}/install"

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
