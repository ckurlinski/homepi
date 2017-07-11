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
# systemd name
	_sysd_name() {
		sysd_name="${git_node_name}"
	}
#------------------------------------------------------------------------------#
# Main PoolController installer
_pool_controller_install() {
	_sysd_name
  _get_repo
  _get_branch
  _nodejs_software_install
  _npm_create_executable
  _npm_create_sysd_exec
}
