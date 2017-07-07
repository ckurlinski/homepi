#!/bin/bash

# Select service
# list is defined in config/base.conf
  _systemd_service_select() {
    l0=${_systemd_service_list}
    list_template
    _selected_service=${_list_output}
  }

# Show systemd service status
	_systemd_service_status() {
    _systemd_service_select
		_header "${_selected_service} Status"
		sudo systemctl status -l ${_selected_service}
		_success "${_selected_service} Running....."
	}

# Enable systemd service
	_systemd_service_enable() {
    _systemd_service_select
		_header "Enabling ${_selected_service}"
		sudo systemctl enable ${_selected_service}
		_success "${_selected_service} Enabled"
	}

# Disable systemd service
	_systemd_service_disable() {
    _systemd_service_select
		_header "Disabling ${_selected_service}"
		sudo systemctl disable ${_selected_service}
		_success "${_selected_service} Disabled"
	}

# Stop systemd service
	_systemd_service_stop() {
    _systemd_service_select
		_header "Stopping ${_selected_service}"
		sudo systemctl stop ${_selected_service}
		_success "${_selected_service} Stopped"
	}

# Start systemd service
	_systemd_service_start() {
    _systemd_service_select
		_header "Starting ${_selected_service}"
		sudo systemctl start ${_selected_service}
		_success "${_selected_service} Started"
	}

# Restart systemd service
	_systemd_service_restart() {
    _systemd_service_select
		_header "Restarting ${_selected_service}"
		sudo systemctl restart ${_selected_service}
		_success "${_selected_service} Restarted"
	}

# Reload systemd daemon
	_systemd_reload_daemon() {
		_header "Reloading systemd daemon"
		sudo systemctl daemon-reload
		_success "systemd daemon reloaded"
	}