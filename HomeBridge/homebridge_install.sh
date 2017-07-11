#!/bin/bash
#------------------------------------------------------------------------------#
# base directory
	hb_base_dir="/var/lib/${sysd_name}"
#------------------------------------------------------------------------------#
# Temp config
	hb_config_tmp="config.raw"
#------------------------------------------------------------------------------#
# Default config.json path
	hb_config_json="${hb_base_dir}/config.json"
#------------------------------------------------------------------------------#
# HomeBridge install list
	hb_install_list=(
		homebridge
		homebridge-server
	)
#------------------------------------------------------------------------------#
# set systemd name
	_hb_sysd_name() {
		sysd_name="homebridge"
	}
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
					npm install -g --unsafe-perm --silent $i > /dev/null
				_success $i
			done
		## Create Symbolic Links
			_header "Creating symbolic link to /usr/bin/homebridge"
				sudo update-alternatives --install "/usr/bin/homebridge" "homebridge" "${g_node_dir}/lib/node_modules/homebridge/bin/homebridge" 1
			_success "homebridge"
		## Create HomeBridge working directory
			_header "Create HomeBridge Var Directory"
				sudo mkdir -p ${hb_base_dir}
			_success ${hb_base_dir}
	}
#------------------------------------------------------------------------------#
# Homebridge Install
	_hb_install_main() {
		_hb_sysd_name
		_hb_depends_install
		_hb_user_setup
		_hb_install
	}
#------------------------------------------------------------------------------#
