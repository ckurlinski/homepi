#!/bin/bash
#------------------------------------------------------------------------------#
# systemd vars
  _hb_sysd_set_var() {
    sysd_name="${hb_name}"
    git_node_dir"${hb_base_dir}"
  }
#------------------------------------------------------------------------------#
# HomeBridge systemd service Installation
_homebridge_service_install() {
	_hb_sysd_set_var
  _service_cap_name
  _sysd_services_remove
  _sysd_service_setup
  _sysd_service_defaults_setup
  _sysd_service_install
}
