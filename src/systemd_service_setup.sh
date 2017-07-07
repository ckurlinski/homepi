#!/bin/bash

# Existing System Service Check, Stop, and Removal
	_systemd_services_remove() {
		## Stop and disable existing services
		if [ $(sudo ps -aux | grep -c '^${_systemd_service_name}') = 1 ]; then
			_header "Stopping and removing ${_systemd_service_name} Services"
			sudo systemctl stop ${_systemd_service_name}
			sudo systemctl disable ${_systemd_service_name}
			sudo systemctl daemon-reload
			_removed "Stopping and removing ${_systemd_service_name} Services - Done!"
		fi
		## Remove Existing server file
		if [ -e ${_systemd_service_file} ]; then
			_header "Removing Existing server file - ${_systemd_service_file}"
			sudo rm -rf ${_systemd_service_file}
			_removed "Removed Existing server file - ${_systemd_service_file}"
		fi
		## Remove Existing Service Default file
		if [ -e ${_systemd_service_default_file} ]; then
			_header "Removing Existing Service Default file - ${_systemd_service_default_file}"
			sudo rm -rf ${_systemd_service_default_file}
			_removed "Removed Existing Service Default file - ${_systemd_service_default_file}"
		fi
	}

# systemd service setup
	_systemd_service_setup() {
			_header "Installing Service : ${_systemd_service_file}"
		## Config file is called from config/*.conf -- * is the name of the service
		## Create Service file
			_header "Installing ${_systemd_service_file}"
			for i in "${_systemd_service_file_list[@]}"; do
				sudo echo $i >> ${_systemd_service_file}
			done
			_success "Installed ${_systemd_service_file}"
		## Show Service File
			_note ${_systemd_service_file}
			_sep
			cat ${_systemd_service_file}
			_sep
	}
# systemd service defaults config
	_systemd_service_defaults_setup() {
		## Stop existing service
			_systemd_services_remove
		## Run service config install
			_systemd_service_setup
		## Create service defaults file - source homebridge_defaults.conf @ homebridge_defaults_list
			_header "Installing Service Defaults - ${_systemd_service_default_file}"
			for i in "${_systemd_service_default_list[@]}"; do
				sudo echo $i >> ${_systemd_service_default_file}
			done
			_success "Install ${_systemd_service_default_file}"
		## Show service defaults file
			_sep
			cat ${_systemd_service_default_file}
			_sep
		## Setting permissions - systemd service
			_header "Setting default permissions on files and folders"
			_header ${_systemd_service_file}
			sudo chown ${_username}:${_username} ${_systemd_service_file}
			sudo chmod 644 ${_systemd_service_file}
			_success ${_systemd_service_file}
		## Seting permissions - HomeBridge service defaults
			_header  ${_systemd_service_default_file}
			sudo chown ${_username}:${_username} ${_systemd_service_default_file}
			sudo chmod 644 ${_systemd_service_default_file}
			_success ${_systemd_service_default_file}
	}
# Start systemd services
	_start_systemd_fn() {
		## Reload systemd daemon
			_header "Reloading systemd daemon"
			sudo systemctl daemon-reload
			_success "systemd daemon reloaded"
		## Enable service
			_header "Enabling ${_systemd_service_name} service"
			sudo systemctl enable ${_systemd_service_name}
			_success "${_systemd_service_name} Enabled"
		## Start service
			_header "Starting ${_systemd_service_name}"
			sudo systemctl restart ${_systemd_service_name}
			_success "${_systemd_service_name} started"
	}
# Show systemd service status
	_systemd_service_status() {
		## Show systemd service status
			_header "${_systemd_service_name} Status"
			sudo systemctl status -l ${_systemd_service_name}
			_success "${_systemd_service_name} Running....."
	}

# systemd Service install Function
	_systemd_service_install_fn() {
		_systemd_services_remove
		_systemd_service_setup
		_systemd_service_defaults_setup
		_start_systemd_fn
	}
