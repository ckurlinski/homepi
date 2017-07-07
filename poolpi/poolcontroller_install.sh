#!/bin/bash

source config/base.conf
source config/homebridge.conf
source config/poolpi.conf

_pool_controller_install() {
  _install_git_software_fn
}
