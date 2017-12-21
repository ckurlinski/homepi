#!/bin/bash
#------------------------------------------------------------------------------#
## _hb_sysd_name ##
# set systemd service name
	_hb_sysd_name() {
		sysd_name="${hb_name}"
	}
#------------------------------------------------------------------------------#
## _hb_depends_install ##
# HomeBridge Install Dependencies
	_hb_depends_install() {
		_system_depends_install
	}
#------------------------------------------------------------------------------#
## _hb_user_setup ##
# HomeBridge User Setup
	_hb_user_setup() {
		_system_user_setup
	}
#------------------------------------------------------------------------------#
## _hb_install ##
# Install HomeBridge-server
	_hb_install() {
		## Install nodes
			for i in "${hb_install_list[@]}"; do
				_header "Installing $i"
				cd ${_install_dir}
					${g_npm_install} --silent $i > /dev/null
				_success $i
			done
	}
#------------------------------------------------------------------------------#
## _hb_sym_link ##
# Create symbolic links to homebridge executable
	_hb_sym_link() {
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
## _hb_install_main ##
# Homebridge Install
	_hb_install_main() {
		_hb_sysd_name
		_hb_depends_install
		_hb_user_setup
		_hb_install
		_hb_sym_link
	}
#------------------------------------------------------------------------------#
