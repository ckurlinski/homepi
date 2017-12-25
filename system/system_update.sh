#!/bin/bash
#------------------------------------------------------------------------------#
# Update apt cache and upgrade
	_menu_item=1
	_menu_task="_system_update"
	_system_update() {
		_header "Updating apt cache"
		sudo apt-get update > /dev/null
		_header "Updating apt cache - Done!"
		_header "Upgrading System"
		sudo apt-get upgrade -y > /dev/null
		_header "Upgrading System - Done!"
	}
#------------------------------------------------------------------------------#
# Install Dependencies
	_system_depends_install() {
		for i in "${depends_install_list[@]}"; do
			_header "Checking Dependencies..."
			if [[ $(dpkg-query --show | grep -wc $i) == 0 ]]; then
				_error "Dependency missing"
				_header "Installing Dependency - $i"
				sudo apt install -y $i  > /dev/null
				_success $i
			else
				_success "Dependency Installed - $i"
			fi
		done
	}
#------------------------------------------------------------------------------#
