#!/bin/bash

source config/poolpi.conf

_pool_controller_service_status() {
  _systemd_service_status
}
