#!/bin/bash

source config/poolpi.conf
source config/homebridge.conf
source config/base.conf

_pool_controller_service_install() {
  _systemd_service_install_fn
}
