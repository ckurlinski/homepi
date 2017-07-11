#!/bin/bash

# Set systemd service to all caps
	_service_cap_name() {
		_header "Capitolizing systemd service name: ${sysd_service}"
		str=${sysd_service}
			_all_caps
		sysd_service_caps="${str_caps}"
		_success "${sysd_service} -> ${sysd_service_caps}"
		_sep
	}

# Existing System Service Check, Stop, and Removal
	_sysd_services_remove() {
		## Stop and disable existing services
		if [ $(sudo ps -aux | grep -c '^${sysd_service}') = 1 ]; then
			_header "Stopping and removing ${sysd_service} Services"
			sudo systemctl stop ${sysd_service}
			sudo systemctl disable ${sysd_service}
			sudo systemctl daemon-reload
			_removed "Stopping and removing ${sysd_service} Services - Done!"
		fi
		## Remove existing service file
		if [ -e ${sysd_service_file} ]; then
			_header "Removing Existing server file - ${sysd_service_file}"
			sudo rm -rf ${sysd_service_file}
			_removed "Removed Existing server file - ${sysd_service_file}"
		fi
		## Remove existing  service default file
		if [ -e ${sysd_default_file} ]; then
			_header "Removing Existing Service Default file - ${sysd_default_file}"
			sudo rm -rf ${sysd_default_file}
			_removed "Removed Existing Service Default file - ${sysd_default_file}"
		fi
	}

# systemd service setup
	_sysd_service_setup() {
			_header "Installing Service : ${sysd_service_file}"
		## Config file is called from config/*.conf -- * is the name of the service
		## Create Service file
			_header "Installing ${sysd_service_file}"
			for i in "${sysd_service_list[@]}"; do
				sudo echo $i >> ${sysd_service_file}
			done
			_success "Installed ${sysd_service_file}"
		## Show Service File
			_note ${sysd_service_file}
			_sep
			cat ${sysd_service_file}
			_sep
	}
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
# systemd Service install Function
	_sysd_service_install() {
		_sysd_services_remove
		_sysd_service_setup
		_sysd_service_defaults_setup
		_sysd_reload_daemon
		_header "Starting ${sysd_service}"
		sudo systemctl start ${sysd_service}
		_success "${sysd_service} Started"
	}
