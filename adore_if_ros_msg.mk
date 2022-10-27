# This Makefile contains useful targets that can be included in downstream projects.


ifndef adore_if_ros_msg.mk

adore_if_ros_msg.mk:=""

adore_if_ros_msg.mk_MAKEFILE_PATH:= $(shell dirname "$(abspath "$(lastword $(MAKEFILE_LIST))")")


MAKEFLAGS += --no-print-directory


.EXPORT_ALL_VARIABLES:
adore_if_ros_msg_project="adore_if_ros_msg"
adore_if_ros_msg_tag=$(shell cd "${adore_if_ros_msg.mk_MAKEFILE_PATH}/make_gadgets" && make get_sanitized_branch_name REPO_DIRECTORY=${adore_if_ros_msg.mk_MAKEFILE_PATH})
adore_if_ros_msg_image=${adore_if_ros_msg_project}:${adore_if_ros_msg_tag}

.PHONY: build_adore_if_ros_msg 
build_adore_if_ros_msg: ## Build adore_if_ros_msg
	cd "${adore_if_ros_msg.mk_MAKEFILE_PATH}" && make

.PHONY: clean_adore_if_ros_msg
clean_adore_if_ros_msg: ## Clean adore_if_ros_msg build artifacts
	cd "${adore_if_ros_msg.mk_MAKEFILE_PATH}" && make clean

.PHONY: branch_adore_if_ros_msg
branch_adore_if_ros_msg: ## Returns the current docker safe/sanitized branch for adore_if_ros_msg
	@printf "%s\n" ${adore_if_ros_msg_tag}

.PHONY: image_adore_if_ros_msg
image_adore_if_ros_msg: ## Returns the current docker image name for adore_if_ros_msg
	@printf "%s\n" ${adore_if_ros_msg_image}

.PHONY: update_adore_if_ros_msg
update_adore_if_ros_msg:
	cd "${Makefile.adore_adore_sim.in_MAKEFILE_PATH}" && git pull

endif
