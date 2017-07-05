#!/bin/bash

# Install HomeBridge
	_node_setup() {
		## List of nodes to install
			node_list=(
				homebridge
				homebridge-server@latest
			)
		## Install nodes
			for i in "${node_list[@]}"; do
				_header "Installing $i"
				sudo -H -u ${_username} bash -c 'npm install --unsafe-perm --silent $i > /dev/null'
				_success $i
			done
		## Create Symbolic Links
			_header "Creating symbolic link to /usr/bin/homebridge"
			sudo update-alternatives --install "/usr/bin/homebridge" "homebridge" "${_install_dir}/node_modules/homebridge/bin/homebridge" 1
			_success "homebridge"
		## Create HomeBridge working directory
			_header "Create HomeBridge Var Directory"
			sudo mkdir -p ${_homebridge_base}
			_success ${_homebridge_base}
	}

  # HomeBridge User Setup
  	_homebridge_user_setup() {
  	  if [ $(getent passwd ${_username}) ]; then
  	    _header "${_username} exists....."
  	  else
  	    _header "Creating ${_username}"
  	    sudo useradd -M --system ${_username}
  			_success "Created ${_username}"
  	  fi
  		# Add homebridge user to the gpio group
  		if [ $(id -nG ${_username} | grep -c "gpio") == 0 ]; then
  			_error "${_username} is not a member of gpio"
  			_header "Adding ${_username} to the gpio group"
  			sudo usermod -G gpio ${_username}
  			_success "Added ${_username} to the gpio group"
  		fi
  		# Add homebridge user to the system group
  		if [ $(id -nG ${_username} | grep -c "system") == 0 ]; then
  			_error "${_username} is not a member of system"
  			_header "Adding ${_username} to the system group"
  			sudo usermod -G system ${_username}
  			_success "Added ${_username} to the system group"
  		fi
  	}
