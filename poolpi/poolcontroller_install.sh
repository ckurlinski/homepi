#!/bin/bash

source config/poolpi.conf
source config/homebridge.conf

_pool_controller_install() {
  _install_git_software_fn
}
