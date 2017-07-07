#!/bin/bash

# Select service
# list is defined in config/base.conf
  _systemd_service_select() {
    l0=(`echo ${_systemd_service_list[@]}`)
    list_template
    _selected_service=${_list_output}
    systemd_menu
  }

# Show systemd service status
	_systemd_service_status() {
    _systemd_service_select
		_header "${_selected_service} Status"
		sudo systemctl status -l ${_selected_service}
		_success "${_selected_service} Running....."
    systemd_menu
	}

# Enable systemd service
	_systemd_service_enable() {
    _systemd_service_select
		_header "Enabling ${_selected_service}"
		sudo systemctl enable ${_selected_service}
		_success "${_selected_service} Enabled"
    systemd_menu
	}

# Disable systemd service
	_systemd_service_disable() {
    _systemd_service_select
		_header "Disabling ${_selected_service}"
		sudo systemctl disable ${_selected_service}
		_success "${_selected_service} Disabled"
    systemd_menu
	}

# Stop systemd service
	_systemd_service_stop() {
    _systemd_service_select
		_header "Stopping ${_selected_service}"
		sudo systemctl stop ${_selected_service}
		_success "${_selected_service} Stopped"
    systemd_menu
	}

# Start systemd service
	_systemd_service_start() {
    _systemd_service_select
		_header "Starting ${_selected_service}"
		sudo systemctl start ${_selected_service}
		_success "${_selected_service} Started"
    systemd_menu
	}

# Restart systemd service
	_systemd_service_restart() {
    _systemd_service_select
		_header "Restarting ${_selected_service}"
		sudo systemctl restart ${_selected_service}
		_success "${_selected_service} Restarted"
    systemd_menu
	}

# Reload systemd daemon
	_systemd_reload_daemon() {
		_header "Reloading systemd daemon"
		sudo systemctl daemon-reload
		_success "systemd daemon reloaded"
    systemd_menu
	}
