#!/bin/bash
#------------------------------------------------------------------------------#
# HomeBridge Install Dependencies
	_hb_depends_install() {
		_system_depends_install
	}
#------------------------------------------------------------------------------#
# HomeBridge User Setup
	_hb_user_setup() {
		_system_user_setup
	}
#------------------------------------------------------------------------------#
# Install HomeBridge-server
	_hb_install() {
		## Install nodes
			for i in "${hb_install_list[@]}"; do
				_header "Installing $i"
				cd ${_install_dir}
				sudo npm install -g --unsafe-perm --silent $i > /dev/null
				_success $i
			done
		## Create Symbolic Links
			_header "Creating symbolic link to /usr/bin/homebridge"
				sudo update-alternatives --install "/usr/bin/homebridge" "homebridge" "${_node_dir}/lib/node_modules/homebridge/bin/homebridge" 1
			_success "homebridge"
		## Create HomeBridge working directory
			_header "Create HomeBridge Var Directory"
				sudo mkdir -p ${_homebridge_base}
			_success ${_homebridge_base}
	}
#------------------------------------------------------------------------------#
# Homebridge Install
	_hb_install_main() {
		_hb_depends_install
		_hb_user_setup
		_hb_install
	}
#------------------------------------------------------------------------------#
