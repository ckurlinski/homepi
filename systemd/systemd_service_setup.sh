#!/bin/bash
#------------------------------------------------------------------------------#
## _service_cap_name ##
# Set systemd service to all caps
	_service_cap_name() {
		_header "Capitalizing systemd service name: ${sysd_name}"
		str=${sysd_name}
			_all_caps
		sysd_name_caps="${str_caps}"
		sysd_name_service="${sysd_name}.service"
		#--------------------------------------------------------------------------#
		# systemd service description
		  sysd_service_descr="Node.js HomeKit ${sysd_name} Service"
		#--------------------------------------------------------------------------#
		# Complete File name and location of systemd service file
		sysd_service_name="${sysd_service_file}/${sysd_name_service}"
		#--------------------------------------------------------------------------#
		_sep
	}
#------------------------------------------------------------------------------#
## _sysd_services_remove ##
# Existing System Service Check, Stop, and Removal
	_sysd_services_remove() {
		## Stop and disable existing services
		if [ $(sudo ps -aux | grep -c '^${sysd_name}') = 1 ]; then
			_header "Stopping and removing ${sysd_name} Services"
			sudo systemctl stop ${sysd_name}
			sudo systemctl disable ${sysd_name}
			sudo systemctl daemon-reload
			_removed "Stopping and removing ${sysd_name} Services - Done!"
		fi
		## Remove existing service file
		if [ -e ${sysd_service_file} ]; then
			_header "Removing Existing server file - ${sysd_service_name}"
			sudo rm -rf ${sysd_service_name}
			_removed "Removed Existing server file - ${sysd_service_name}"
		fi
		## Remove existing service default file
		if [ -e ${sysd_default_file} ]; then
			_header "Removing Existing Service Default file - ${sysd_default_file}"
			sudo rm -rf ${sysd_default_file}
			_removed "Removed Existing Service Default file - ${sysd_default_file}"
		fi
	}
#------------------------------------------------------------------------------#
## _sysd_service_setup ##
# systemd service setup
	_sysd_service_setup() {
			_header "Installing Service : ${sysd_service_name}"
		## Config file is called from config/*.conf -- * is the name of the service
		## Create Service file
			_header "Installing ${sysd_service_name}"
			for i in "${sysd_service_name[@]}"; do
				sudo echo $i >> ${sysd_service_name}
			done
			_success "Installed ${sysd_service_name}"
		## Show Service File
			_note ${sysd_service_name}
			_sep
			cat ${sysd_service_name}
			_sep
	}
#------------------------------------------------------------------------------#
## _sysd_service_defaults_setup ##
# systemd service defaults config
	_sysd_service_defaults_setup() {
		## Stop existing service
			_sysd_services_remove
		## Run service config install
			_sysd_service_setup
		## Config file is called from config/*.conf -- * is the name of the service
			_header "Installing Service Defaults - ${sysd_default_file}"
			for i in "${sysd_default_list[@]}"; do
				sudo echo $i >> ${sysd_default_file}
			done
			_success "Install ${sysd_default_file}"
		## Show service defaults file
			_sep
			cat ${sysd_default_file}
			_sep
		## Setting permissions - systemd service
			_header "Setting default permissions on files and folders"
			_header ${sysd_service_file}
			sudo chown ${_username}:${_username} ${sysd_service_file}
			sudo chmod 644 ${sysd_service_file}
			_success ${sysd_service_file}
		## Seting permissions - systemd service defaults
			_header  ${sysd_default_file}
			sudo chown ${g_user}:${g_group} ${sysd_default_file}
			sudo chmod 644 ${sysd_default_file}
			_success ${sysd_default_file}
	}
#------------------------------------------------------------------------------#
## _sysd_service_install ##
# systemd Service install Function
	_sysd_service_install() {
		_sysd_services_remove
		_sysd_service_setup
		_sysd_service_defaults_setup
		_sysd_reload_daemon
		_header "Starting ${sysd_name}"
		sudo systemctl start ${sysd_name}
		_success "${sysd_name} Started"
	}
#------------------------------------------------------------------------------#