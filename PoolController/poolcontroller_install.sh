#!/bin/bash
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
