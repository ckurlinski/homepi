#!/bin/bash

# Existing System Service Check, Stop, and Removal
	_system_services_remove() {
		## Stop and disable existing services
		if [ $(sudo ps -aux | grep -c '^homebridge') = 1 ]; then
			_header "Stopping and removing HomeBridge Services"
			sudo systemctl stop homebridge
			sudo systemctl disable homebridge
			sudo systemctl daemon-reload
			_removed "Stopping and removing HomeBridge Services - Done!"
		fi
		## Remove Existing server file
		if [ -e ${_service_file} ]; then
			_header "Removing Existing server file - ${_service_file}"
			sudo rm -rf ${_service_file}
			_removed "Removed Existing server file - ${_service_file}"
		fi
		## Remove Existing Service Default file
		if [ -e ${_service_default_file} ]; then
			_header "Removing Existing Service Default file - ${_service_default_file}"
			sudo rm -rf ${_service_default_file}
			_removed "Removed Existing Service Default file - ${_service_default_file}"
		fi
	}

	# Install HomeBridge extra / dependencies
		_node_dependencies_setup() {
			## List of nodes to install
				node_list=(
					homebridge-gpio-wpi2@latest
					homebridge-cmdaccessory@latest
				)
			## Install nodes
				for i in "${node_list[@]}"; do
					_header "Installing $i"
					sudo npm install -g --silent $i > /dev/null
					_success $i
				done
		}


# HomeBridge systemd service setup
	_homebridge_service_setup() {
			_header "Installing Service : ${_service_file}"
		## Service File list
			_service_file_list=(
				"[Unit]"
				"Description=Node.js HomeKit Server"
				"After=syslog.target network-online.target"
				"[Service]"
				"Type=simple"
				"EnvironmentFile=/etc/default/homebridge"
				"ExecStart=/usr/bin/homebridge \$HOMEBRIDGE_OPTS"
				"Restart=on-failure"
				"RestartSec=10"
				"KillMode=process"
				"[Install]"
				"WantedBy=multi-user.target"
			)
		## Create Service file
			_header "Installing ${_service_file_list}"
			for i in "${_service_file_list[@]}"; do
				sudo echo $i >> ${_service_file}
			done
			_success "Installed ${_service_file}"
		## Show Service File
			_note ${_service_file}
			_sep
			cat ${_service_file}
			_sep
	}
# HomeBridge service defaults config
	_homebridge_defaults_setup() {
		## Stop existing service
			_system_services_remove
		## Run service config install
			_homebridge_service_setup
		## Service Defaults List
			_service_defaults_list=(
				"# Defaults / Configuration options for homebridge"
				"HOMEBRIDGE_OPTS=\"-U /var/lib/homebridge\""
				"# If you uncomment the following line, homebridge will log more"
				"# You can display this via systemd's journalctl: journalctl -f -u homebridge"
				"# DEBUG=*"
			)
		## Create service defaults file - source homebridge_defaults.conf @ homebridge_defaults_list
			_header "Installing Service Defaults - ${_service_default_file}"
			for i in "${_service_defaults_list[@]}"; do
				sudo echo $i >> ${_service_default_file}
			done
			_success "Install ${_service_default_file}"
		## Show service defaults file
			_sep
			cat ${_service_default_file}
			_sep
		## Setting permissions - HomeBridge service
			_header "Setting default permissions on files and folders"
			_header ${_service_file}
			sudo chown ${_username}:${_username} ${_service_file}
			sudo chmod 644 ${_service_file}
			_success ${_service_file}
		## Seting permissions - HomeBridge service defaults
			_header  ${_service_default_file}
			sudo chown ${_username}:${_username} ${_service_default_file}
			sudo chmod 644 ${_service_default_file}
			_success ${_service_default_file}
	}
# HomeBridge Node Name
	_homebridge_node_name() {
		_header "Enter name for Node"
		read _ans
		_ans_check
		_node_name="${_ans}"
		_success "${_node_name}"
	}
# HomeBridge Node Description
	_homebridge_node_description() {
		_header "Enter description for Node"
		read _ans
		_ans_check
		_node_description="${_ans}"
		_success "${_node_description}"
	}
# HomeBridge Node Manufacturer
	_homebridge_node_manufacturer() {
		_header "Enter Manufacturer for Node"
		read _ans
		_ans_check
		_node_manufacturer="${_ans}"
		_success "${_node_manufacturer}"
	}
# HomeBridge Node Device Name
	_homebridge_node_device_name() {
		_header "Enter Device Name for Node"
		read _ans
		_ans_check
		_node_device_name="${_ans}"
		_success "${_node_device_name}"
	}
# HomeBridge Random Username
	_homebridge_username_create_fn() {
		## Define random ranges
			RANGE=255
			number=$RANDOM
			numbera=$RANDOM
			numberb=$RANDOM
			let "number %= $RANGE"
			let "numbera %= $RANGE"
			let "numberb %= $RANGE"
		## Base octet for file
			octets='00:60:2F'
		## Random base16 creation
			octeta=`echo "obase=16;$number" | bc`
			octetb=`echo "obase=16;$numbera" | bc`
			octetc=`echo "obase=16;$numberb" | bc`
		## Show Homebridge User Name
			_homebridge_username="${octets}:${octeta}:${octetb}:${octetc}"
			_header "Generating HomeBridge Usename"
			_warning ${_homebridge_username}
	}
# HomeBridge Random Port generator
	_homebridge_random_port_fn() {
		## Generate random port
			_homebridge_rport=(`shuf -i 40000-65000 -n 1`)
		## Show random port
			_header "Randomizing port"
			_warning ${_homebridge_rport}
	}
# HomeBridge Server Random Port generator
	_homebridge_server_random_port_fn() {
		## Generate random port
			_homebridge_server_rport=(`shuf -i 40000-65000 -n 1`)
		## Show random port
			_header "Randomizing port"
			_warning ${_homebridge_server_rport}
	}
# Random access code generator
	_homebridge_pin_code_fn() {
		## Generate (8) random numbers for HomeBridge pin
			a=`echo $((1 + RANDOM % 9))`
			b=`echo $((1 + RANDOM % 9))`
			c=`echo $((1 + RANDOM % 9))`
			d=`echo $((1 + RANDOM % 9))`
			e=`echo $((1 + RANDOM % 9))`
			f=`echo $((1 + RANDOM % 9))`
			g=`echo $((1 + RANDOM % 9))`
			h=`echo $((1 + RANDOM % 9))`
		## Assemble and format numbers
			_homebridge_pin_code="${a}${b}${c}-${d}${e}-${f}${g}${h}"
		## Show HomeBridge random pin
			_header "Generating HomeBridge access code"
			_warning ${_homebridge_pin_code}
	}
# HomeBridge config.json setup check
	_config_json_setup_check() {
		## Stop existing HomeBridge service
			if [ $(sudo ps -aux | grep -c '^homebridge') = 1 ]; then
				_header "Stopping and removing HomeBridge Services"
				sudo systemctl stop homebridge
				_removed "Stopping HomeBridge Services - Done!"
			fi
		## Remove existing HomeBridge config.tmp
			if [ -e ${_config_json_tmp} ]; then
				_header "Removing" ${_config_json_tmp}
				sudo rm -rf ${_config_json_tmp}
				_removed "Removed" ${_config_json_tmp}
			fi
		## Remove existing HomeBridge config.json
			if [ -e ${_config_json} ]; then
				_header "Removing" ${_config_json}
				sudo rm -rf ${_config_json}
				_removed "Removed" ${_config_json}
			fi
	}
# HomeBridge config.json Create
	_create_json_file() {
		## base json config
			_json_config_list=(
			"{"
			"\"bridge\" : {"
			"\"username\" : \"${_homebridge_username}\","
			"\"name\" : \"${_node_name}\","
			"\"pin\" : \"${_homebridge_pin_code}\","
			"\"port\" : \"${_homebridge_rport}\""
			"},"
			"\"platforms\" : ["
			"{"
			"\"port\" : \"${_homebridge_server_rport}\","
			"\"restart\" : \"sudo systemctl restart homebridge\","
			"\"name\" : \"Homebridge Server\","
			"\"log\" : \"systemd\","
			"\"platform\" : \"Server\""
			"}"
			"]"
			"}"
			)
		## Create the json config file
			_header "Creating tmp config : ${_config_json_tmp}"
			for i in "${_json_config_list[@]}"; do
				sudo echo $i >> ${_config_json_tmp}
			done
			_success "Created tmp config : ${_config_json_tmp}"
			_header "Preforming cleanup - ${_config_json_tmp} to ${_config_json}"
			sudo cat ${_config_json_tmp} | python -m json.tool > ${_config_json}
			sudo rm -rf ${_config_json_tmp}
			_success "Created ${_config_json}"
	}
# HomeBridge config.json setup
	_config_json_setup() {
		## Install command line scripts
		#	_faac_door_scripts_install
		## Check for existing install
			_config_json_setup_check
		## HomeBridge Node Name
		#	_homebridge_node_name
		## HomeBridge Node Description
			_homebridge_node_description
		## HomeBridge Node Manufacturer
			_homebridge_node_manufacturer
		## HomeBridge Node Device Name
			_homebridge_node_device_name
		## Create Random Username
			_homebridge_username_create_fn
		## Create random Port
			_homebridge_random_port_fn
		## Create random Port
			_homebridge_server_random_port_fn
		## Create randon pin
			_homebridge_pin_code_fn
		## call edit_json.sh to process the json file
			_create_json_file
		## Show HomeBridge config json
			_note ${_config_json}
			_sep
			cat  ${_config_json}
			_sep
			_success  ${_config_json}
		## Change ownership on HomeBridge config folder and children
			_header "Changing owner and group to ${username}:${username} on ${_homebridge_base} and children"
			sudo chown -R ${_username}:${_username} ${_homebridge_base}
			_success "Changed ownership"
		## Set permissions on HomeBridge folder and children
			sudo chmod -R 755 ${_homebridge_base}
			_success "Changed Permissions"
	}
# Start systemd services
	_start_homebridge_fn() {
		## Reload systemd daemon
			_header "Reloading systemd daemon"
			sudo systemctl daemon-reload
			_success "systemd daemon reloaded"
		## Enable HomeBridge service
			_header "Enabling HomeBridge service"
			sudo systemctl enable homebridge
			_success "HomeBridge Enabled"
		## Start HomeBridge service
			_header "Starting HomeBridge"
			sudo systemctl restart homebridge
			_success "HomeBridge started"
	}
# Show HomeBridge service status
	_service_status() {
		## Show HomeBridge service status
			_header "HomeBridge Status"
			sudo systemctl status -l homebridge
			_success "HomeBridge Running....."
	}
