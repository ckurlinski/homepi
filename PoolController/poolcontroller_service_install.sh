#!/bin/bash
# systemd name
	_sysd_name() {
		sysd_name="${git_node_name}"
	}
#------------------------------------------------------------------------------#
# nodejs_poolController Installation
_pool_controller_service_install() {
	_sysd_name
  _service_cap_name
  _sysd_services_remove
}
