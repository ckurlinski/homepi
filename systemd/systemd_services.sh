#!/bin/bash

# Show systemd service status
	_systemd_service_status() {
    l0=(`echo ${_systemd_service_list[@]}`)
    list_template
    _selected_service=${_list_output}
		_header "${_selected_service} Status"
		sudo systemctl status -l ${_selected_service}
		_success "${_selected_service} Running....."
    unset $l0
	}

# Enable systemd service
	_systemd_service_enable() {
    l0=(`echo ${_systemd_service_list[@]}`)
    list_template
    _selected_service=${_list_output}
		_header "Enabling ${_selected_service}"
		sudo systemctl enable ${_selected_service}
		_success "${_selected_service} Enabled"
    unset $l0
	}

# Disable systemd service
	_systemd_service_disable() {
    l0=(`echo ${_systemd_service_list[@]}`)
    list_template
    _selected_service=${_list_output}
		_header "Disabling ${_selected_service}"
		sudo systemctl disable ${_selected_service}
		_success "${_selected_service} Disabled"
    unset $l0
	}

# Stop systemd service
	_systemd_service_stop() {
    l0=(`echo ${_systemd_service_list[@]}`)
    list_template
    _selected_service=${_list_output}
		_header "Stopping ${_selected_service}"
		sudo systemctl stop ${_selected_service}
		_success "${_selected_service} Stopped"
    unset $l0
	}

# Start systemd service
	_systemd_service_start() {
    l0=(`echo ${_systemd_service_list[@]}`)
    list_template
    _selected_service=${_list_output}
		_header "Starting ${_selected_service}"
		sudo systemctl start ${_selected_service}
		_success "${_selected_service} Started"
    unset $l0
	}

# Restart systemd service
	_systemd_service_restart() {
    l0=(`echo ${_systemd_service_list[@]}`)
    list_template
    _selected_service=${_list_output}
		_header "Restarting ${_selected_service}"
		sudo systemctl restart ${_selected_service}
		_success "${_selected_service} Restarted"
    unset $l0
	}

# Reload systemd daemon
	_systemd_reload_daemon() {
		_header "Reloading systemd daemon"
		sudo systemctl daemon-reload
		_success "systemd daemon reloaded"
	}
