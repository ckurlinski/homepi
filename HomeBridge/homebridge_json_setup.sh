#!/bin/bash
#------------------------------------------------------------------------------#
# systemd service name
	sysd_name="homebridge"
#------------------------------------------------------------------------------#
# base directory
	hb_base_dir="/var/lib/${sysd_name}"
#------------------------------------------------------------------------------#
# Temp config
	hb_config_tmp="config.raw"
#------------------------------------------------------------------------------#
# Default config.json path
	hb_config_json="${hb_base_dir}/config.json"
#------------------------------------------------------------------------------#
# HomeBridge install list
	hb_install_list=(
		homebridge
		homebridge-server
	)
#------------------------------------------------------------------------------#
# base json config
	hb_config_list=(
		"{"
		"\"bridge\" : {"
		"\"username\" : \"${hb_user_id}\","
		"\"name\" : \"${hb_node_name}\","
		"\"pin\" : \"${hb_pin_code}\","
		"\"port\" : \"${hb_random_port}\""
		"},"
		"\"platforms\" : ["
		"{"
		"\"port\" : \"${hb_server_port}\","
		"\"restart\" : \"sudo systemctl restart ${sysd_name}\","
		"\"name\" : \"${hb_node_name}\","
		"\"log\" : \"systemd\","
		"\"platform\" : \"Server\""
		"}"
		"]"
		"}"
	)
#------------------------------------------------------------------------------#
# HomeBridge Node Name
	_hb_node_name() {
		_header "Enter name for instance"
		read _ans
		_ans_check
		hb_node_name="${_ans}"
		_success "${hb_node_name}"
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Description
	_hb_node_desc() {
		_header "Enter description for ${sysd_name} Node"
		read _ans
		_ans_check
		hb_node_desc="${_ans}"
		_success "${hb_node_desc}"
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Manufacturer
	_hb_node_man() {
		_header "Enter Manufacturer for ${sysd_name} Node"
		read _ans
		_ans_check
		hb_node_man="${_ans}"
		_success "${hb_node_man}"
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Device Name
	_hb_node_device_name() {
		_header "Enter Device ${sysd_name} Name for Node"
		read _ans
		_ans_check
		hb_node_device_name="${_ans}"
		_success "${hb_node_device_name}"
	}
#------------------------------------------------------------------------------#
# HomeBridge Random User ID
	_hb_user_id() {
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
			hb_user_id="${octets}:${octeta}:${octetb}:${octetc}"
			_header "Generating ${sysd_name} Usename"
			_warning ${hb_user_id}
	}
#------------------------------------------------------------------------------#
# HomeBridge Random Port generator
	_hb_random_port() {
		## Generate random port
			hb_random_port=(`shuf -i 40000-65000 -n 1`)
		## Show random port
			_header "${sysd_name} - Randomizing port"
			_warning ${hb_random_port}
	}
#------------------------------------------------------------------------------#
# HomeBridge Server Random Port generator
	_hb_server_port() {
		## Generate random port
			hb_server_port=(`shuf -i 40000-65000 -n 1`)
		## Show random port
			_header "${sysd_name} - Randomizing port"
			_warning ${hb_server_port}
	}
#------------------------------------------------------------------------------#
# Random access code generator
	_hb_pin_code() {
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
			hb_pin_code="${a}${b}${c}-${d}${e}-${f}${g}${h}"
		## Show HomeBridge random pin
			_header "Generating ${sysd_name} access code"
			_warning ${hb_pin_code}
	}
#------------------------------------------------------------------------------#
# HomeBridge config.json setup check
	_hb_config_json_setup() {
		## Stop existing HomeBridge service
			if [ $(sudo ps -aux | grep -c '^${sysd_name}') = 1 ]; then
				_header "Stopping ${sysd_name} Services"
					sudo systemctl stop homebridge
				_removed "Stopping ${sysd_name} Services - Done!"
			fi
		## Remove existing HomeBridge config.tmp
			if [ -e ${hb_config_tmp} ]; then
				_header "Removing" ${hb_config_tmp}
				sudo rm -rf ${hb_config_tmp}
				_removed "Removed" ${hb_config_tmp}
			fi
		## Remove existing HomeBridge config.json
			if [ -e ${_config_json} ]; then
				_header "Removing" ${_config_json}
				sudo rm -rf ${_config_json}
				_removed "Removed" ${_config_json}
			fi
	}
#------------------------------------------------------------------------------#
# HomeBridge config.json Create
	_hb_config_json_install() {
		## Create the json config file
			_header "Creating tmp config : ${hb_config_tmp}"
			for i in "${hb_config_list[@]}"; do
				sudo echo $i >> ${hb_config_tmp}
			done
			_success "Created tmp config : ${hb_config_tmp}"
			_header "Preforming cleanup - ${hb_config_tmp} to ${hb_config_json}"
			sudo cat ${hb_config_tmp} | python -m json.tool > ${hb_config_json}
			sudo rm -rf ${hb_config_tmp}
			_success "Created ${hb_config_json}"
	}
#------------------------------------------------------------------------------#
# Homebridge Create json config
	_hb_config_install() {
		# HomeBridge Node Name
			_hb_node_name
		# HomeBridge Node Description
			_hb_node_desc
		# HomeBridge Node Manufacturer
			_hb_node_man
		# HomeBridge Node Device Name
			_hb_node_device_name
		# Create Random Username
			_hb_user_id
		# Create random Port
			_hb_random_port
		# Create random Port
			_hb_server_port
		# Create randon pin
			_hb_pin_code
		# Create config temp file
			_hb_config_json_install
		# Create config.json file
			_hb_config_json_setup
		# Change ownership on HomeBridge config folder and children
			_header "Changing ownership on ${hb_base_dir}"
				sudo chown -R ${g_user}:${g_group} ${hb_base_dir}
			_success "Changed ownership"
		# Set permissions on HomeBridge folder and children
			_header "Setting permissions on ${hb_base_dir}"
				sudo chmod -R 755 ${hb_base_dir}
			_success "Changed Permissions"
}
#------------------------------------------------------------------------------#
