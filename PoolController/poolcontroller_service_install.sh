#!/bin/bash
#------------------------------------------------------------------------------#
## _sysd_name ##
# systemd name
	_sysd_name() {
		sysd_name="${git_node_name}"
	}
#------------------------------------------------------------------------------#
## _pool_controller_service_install ##
# nodejs_poolController Installation
  _pool_controller_service_install() {
    _sysd_name
    _service_cap_name
    _sysd_services_remove
    _service_cap_name
    _sysd_services_remove
    _sysd_service_setup
    _sysd_service_defaults_setup
    _sysd_service_install
  }
#------------------------------------------------------------------------------#