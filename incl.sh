#!/bin/bash

# Execute this:
# find . -print | grep .conf | sed 's/\.\///g' | awk '{print"source "$0}'
# to update the Config file list
source config/base.conf
source config/homebridge.conf
source config/npm.conf
source config/poolpi.conf

# Execute this:
# find . -print | grep .sh | xargs chmod 644
# to chmod to 644 of all sub scripts

# Execute this:
# find . -print | grep .sh | sed 's/\.\///g' | awk '{print"source "$0}'
# to update the source Shell Script list
source npm/npm_status.sh
source poolpi/poolcontroller_install.sh
source poolpi/poolcontroller_service_install.sh
source poolpi/src/circuit_select.sh
source poolpi/src/circuit_status.sh
source poolpi/src/circuit_toggle.sh
source src/base_script.sh
source src/faac_install.sh
source src/homebridge_install.sh
source src/homebridge_service_install.sh
source src/nodejs_install.sh
source src/npm_git_install.sh
source src/npm_install.sh
source src/system_update.sh
source systemd/systemd_service_setup.sh
source systemd/systemd_services.sh
