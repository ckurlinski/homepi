#!/bin/bash

#------------------------------------------------------------------------------#
# User Setup
	_system_user_setup() {
		if [ $(getent passwd ${g_user}) ]; then
			_header "User: ${g_user} exists....."
		else
			_header "Creating ${g_user}"
			sudo useradd -M --system ${g_user}
			_success "Created ${g_user}"
		fi
		# Add user to the gpio group
		if [ $(id -nG ${g_user} | grep -c "gpio") == 0 ]; then
			_error "${g_user} is not a member of gpio"
			_header "Adding ${g_user} to the gpio group"
			sudo usermod -G gpio ${g_user}
			_success "Added ${g_user} to the gpio group"
		fi
	}
