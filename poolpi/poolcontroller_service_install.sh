#!/bin/bash

source config/base.conf
source config/homebridge.conf
source config/poolpi.conf

_pool_controller_service_install() {
  _systemd_service_install_fn
}
