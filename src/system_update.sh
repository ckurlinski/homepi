#!/bin/bash

# Update apt cache and upgrade
	_base_update() {
		_header "Updating apt cache"
		sudo apt-get update > /dev/null
		_header "Updating apt cache - Done!"
		_header "Upgrading System"
		sudo apt-get upgrade -y > /dev/null
		_header "Upgrading System - Done!"
	}
# Install Dependencies
	_depends_install() {
		## depends_install_list
			depends_install_list=(
				libavahi-compat-libdnssd-dev
				wget
				make
				bc
				wiringpi
			)
		## Install dependencies
			for i in "${depends_install_list[@]}"; do
				_header "Installing Dependency - $i"
				sudo apt-get install -y $i  > /dev/null
				_success $i
			done
	}
