#!/bin/bash
#------------------------------------------------------------------------------#
# Script sources
#------------------------------------------------------------------------------#
# git repo address
	git_repo="https://github.com/tagyoureit/nodejs-poolController.git"
#------------------------------------------------------------------------------#
# git repo name
	git_name="nodejs-poolController"
#------------------------------------------------------------------------------#
# git branch name
	git_branch="4.x-DEV"
#------------------------------------------------------------------------------#
# git reference name
	git_node_name="poolController"
#------------------------------------------------------------------------------#
# npm start command with prefix added
	npm_start_cmd="npm start --prefix ${git_node_dir}/${sysd_name}"
#------------------------------------------------------------------------------#
# systemd service name
	sysd_name="${git_node_name}"
#------------------------------------------------------------------------------#
# nodejs_poolController Installation
_pool_controller_service_install() {
  _service_cap_name
  _sysd_services_remove
}
