#!/bin/bash
#------------------------------------------------------------------------------#
## _sysd_unit_installed_test ##
# Test to see if the systemd daemon is installed
	_sysd_unit_installed_test() {
	if [[ -z $(systemctl list-units | grep unbound) ]]; then 
		_state=0
	else
		_state=1
	fi
	}
#------------------------------------------------------------------------------#
## _sysd_service_select ##
# Select service
# list is defined in config/base.conf
  _sysd_service_select() {
    _l0=(`echo ${sysd_service_monitor_list[@]}`)
    _list_template
    _selected_service=${_list_output}
  }
#------------------------------------------------------------------------------#
## _sysd_service_status_test ##
# systemd service status check
  _sysd_service_status_test() {
    if [[ $(systemctl is-active ${_selected_service}) = "inactive" ]]; then
      _warning "${_selected_service} is stopped"
    else
      _success "${_selected_service} Running....."
      systemctl status -l ${_selected_service}
      _sep
    fi
  }
#------------------------------------------------------------------------------#
## _sysd_service_status ##
# Show systemd service status
	_sysd_service_status() {
    _sysd_service_select
		_header "${_selected_service} Status"
		_sysd_unit_installed_test
		if [[ ${_state} -eq 1 ]]; then
			_sysd_service_status_test
		else
			_error "${_selected_service} service is not installed"
		fi
	}
#------------------------------------------------------------------------------#
## _sysd_service_enabled_test ##
# Check if service is enabled 
	_sysd_service_enabled_test() {
		_sysd_service_select
		if [[ $(systemctl is-enabled ${_selected_service}) = "disabled" ]]; then
			_warning "${_selected_service} is disabled"
			sysd_status=0
		else
			_success "${_selected_service} is enabled"
			sysd_status=1
		fi
	}
#------------------------------------------------------------------------------#
## _sysd_service_enable ##
# Enable systemd service
	_sysd_service_enable() {
		_sysd_service_enabled_test
		case ${sysd_status} in
			0 )	_header "Enable ${_selected_service} to start at boot ( y | N )?"
					read _ans
					case ${_ans} in
						y)	_header "Enabling ${_selected_service}"
								sudo systemctl enable ${_selected_service}
								_success "${_selected_service} Enabled"
								;;
						*)	_warning "Leaving ${_selected_service} disabled at boot"
								;;
					esac
					;;
			1 )	_success "${_selected_service} is enabled and will start at boot"
					;;
		esac
	}
#------------------------------------------------------------------------------#
## _sysd_service_disable ##
# Disable systemd service
	_sysd_service_disable() {
    _sysd_service_select
		_header "Disabling ${_selected_service}"
		sudo systemctl disable ${_selected_service}
		_success "${_selected_service} Disabled"
	}
#------------------------------------------------------------------------------#
## _sysd_service_stop ##
# Stop systemd service
	_sysd_service_stop() {
    _sysd_service_select
		_header "Stopping ${_selected_service}"
		sudo systemctl stop ${_selected_service}
		_success "${_selected_service} Stopped"
	}
#------------------------------------------------------------------------------#
## _sysd_service_start ##
# Start systemd service
	_sysd_service_start() {
    _sysd_service_select
		_header "Starting ${_selected_service}"
		sudo systemctl start ${_selected_service}
		_success "${_selected_service} Started"
	}
#------------------------------------------------------------------------------#
## _sysd_service_select ##
# Restart systemd service
	_sysd_service_restart() {
    _sysd_service_select
		_header "Restarting ${_selected_service}"
		sudo systemctl restart ${_selected_service}
		_success "${_selected_service} Restarted"
	}
#------------------------------------------------------------------------------#
## _sysd_reload_daemon ##
# Reload systemd daemon
	_sysd_reload_daemon() {
		_header "Reloading systemd daemon"
		sudo systemctl daemon-reload
		_success "systemd daemon reloaded"
	}
#------------------------------------------------------------------------------#
## _sysd_view_unit_file ##
# View the service's unit config file
	_sysd_view_unit_file() {
		_sysd_service_select
		_header "Viewing ${_selected_service} service config file"
		_sep
			systemctl cat ${_selected_service}.service
		_sep
		_success "Hit the Any Key to continue...."
		read huh
	}
#------------------------------------------------------------------------------#