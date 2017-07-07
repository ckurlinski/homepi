#!/bin/bash

# Execute this:
# find . -print | grep .conf | sed 's/\.\///g' | awk '{print"source "$0}'
# to update the Config file list
source config/homepi.conf
source config/poolpi.conf

# Execute this:
# find . -print | grep .sh | sed 's/\.\///g' | awk '{print"source "$0}'
# to update the source Shell Script list
source poolpi/circuits/overflow/overflow_off.sh
source poolpi/circuits/overflow/overflow_on.sh
source poolpi/circuits/overflow/overflow_status.sh
source poolpi/circuits/vacuum/vac_off.sh
source poolpi/circuits/vacuum/vac_on.sh
source poolpi/circuits/vacuum/vac_status.sh
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
source src/systemd_service_setup.sh
