#!/bin/bash
#------------------------------------------------------------------------------#
# Script sources
source config/base.conf
source config/systemd.conf
source config/poolcontroller.conf
#------------------------------------------------------------------------------#
# nodejs_poolController Installation
_pool_controller_service_install() {
  _service_cap_name
  _sysd_services_remove
}
