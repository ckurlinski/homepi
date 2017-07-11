#!/bin/bash

# Select service
# list is defined in config/base.conf
  _sysd_service_select() {
    _l0=(`echo ${sysd_service_monitor_list[@]}`)
    _list_template
    _selected_service=${_list_output}
  }

# systemd service status check
  _sysd_service_status_test() {
    sysd_check=(`systemctl status ${_selected_service} | grep Active | awk '{print$2}'`)
    if [[ ${sysd_check} == "inactive"]]; then
      _warning "${_selected_service} is stopped"
    else
      _success "${_selected_service} Running....."
      systemctl status -l ${_selected_service}
      _sep
    fi
  }

# Show systemd service status
	_sysd_service_status() {
    _sysd_service_select
		_header "${_selected_service} Status"
		_sysd_service_status_test
	}

# Enable systemd service
	_sysd_service_enable() {
    _sysd_service_select
		_header "Enabling ${_selected_service}"
		sudo systemctl enable ${_selected_service}
		_success "${_selected_service} Enabled"
	}

# Disable systemd service
	_sysd_service_disable() {
    _sysd_service_select
		_header "Disabling ${_selected_service}"
		sudo systemctl disable ${_selected_service}
		_success "${_selected_service} Disabled"
	}

# Stop systemd service
	_sysd_service_stop() {
    _sysd_service_select
		_header "Stopping ${_selected_service}"
		sudo systemctl stop ${_selected_service}
		_success "${_selected_service} Stopped"
	}

# Start systemd service
	_sysd_service_start() {
    _sysd_service_select
		_header "Starting ${_selected_service}"
		sudo systemctl start ${_selected_service}
		_success "${_selected_service} Started"
	}

# Restart systemd service
	_sysd_service_restart() {
    _sysd_service_select
		_header "Restarting ${_selected_service}"
		sudo systemctl restart ${_selected_service}
		_success "${_selected_service} Restarted"
	}

# Reload systemd daemon
	_sysd_reload_daemon() {
		_header "Reloading systemd daemon"
		sudo systemctl daemon-reload
		_success "systemd daemon reloaded"
	}
