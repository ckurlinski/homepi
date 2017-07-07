#!/bin/bash

source config/poolpi.conf
source config/homepi.conf

_pool_controller_install() {
  _install_git_software_fn
}
