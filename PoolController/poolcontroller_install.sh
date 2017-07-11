#!/bin/bash

_pool_controller_install() {
  _get_repo
  _get_branch
  _nodejs_software_install
  _npm_create_executable
  _npm_create_sysd_exec
}
