#!/bin/bash
#------------------------------------------------------------------------------#
# set systemd name
	_hb_sysd_name() {
		sysd_name="${hb_name}"
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
# HomeBridge config.raw Create
	_hb_config_json_tmp() {
		## Create the json config file
			_header "Creating tmp config : ${hb_config_tmp}"
			for i in "${hb_config_list[@]}"; do
				echo $i >> ${hb_config_tmp}
			done
			_success "Created tmp config : ${hb_config_tmp}"
			_sep
			cat ${hb_config_tmp}
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Name
	_hb_node_name() {
		_header "Enter name for ${sysd_name}"
		read _ans
		_ans_check
		hb_node_name="${_ans}"
		_success "${hb_node_name}"
		# Update config.raw
		_note "Updating config.raw - hb_name : ${hb_name}"
			sed -i "s/hb_name/${hb_name}/g" ${hb_config_tmp}
		_sep
		_note "Updating config.raw - hb_node_name : ${hb_node_name}"
			sed -i "s/hb_node_name/${hb_node_name}/g" ${hb_config_tmp}
		_sep
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Manufacturer
	_hb_node_man() {
		_header "Enter Manufacturer for ${sysd_name} Node"
		read _ans
		_ans_check
		hb_node_man="${_ans}"
		_success "${hb_node_man}"
		# Update config.raw
		_note "Updating config.raw - hb_node_man : ${hb_node_man}"
			sed -i "s/hb_node_man/${hb_node_man}/g" ${hb_config_tmp}
		_sep
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Device Name
	_hb_node_device_name() {
		_header "Enter Device ${sysd_name} Name for Node"
			read _ans
		_ans_check
			hb_node_device_name="${_ans}"
		_success "${hb_node_device_name}"
		# Update config.raw
		_note "Updating config.raw - hb_node_device_name : ${hb_node_device_name}"
			sed -i "s/hb_node_device_name/${hb_node_device_name}/g" ${hb_config_tmp}
		_sep
	}
#------------------------------------------------------------------------------#
# HomeBridge Random User ID
	_hb_user_id() {
		# Define random ranges
			RANGE=255
			number=$RANDOM
			numbera=$RANDOM
			numberb=$RANDOM
			let "number %= $RANGE"
			let "numbera %= $RANGE"
			let "numberb %= $RANGE"
		# Base octet for file
			octets='00:60:2F'
		# Random base16 creation
			octeta=`echo "obase=16;$number" | bc`
			octetb=`echo "obase=16;$numbera" | bc`
			octetc=`echo "obase=16;$numberb" | bc`
		# Show Homebridge User Name
			hb_user_id="${octets}:${octeta}:${octetb}:${octetc}"
			_header "Generating ${sysd_name} Usename"
			_warning ${hb_user_id}
		# Update config.raw
		_note "Updating config.raw - hb_user_id : ${hb_user_id}"
			sed -i "s/hb_user_id/${hb_user_id}/g" ${hb_config_tmp}
		_sep
	}
#------------------------------------------------------------------------------#
# HomeBridge Random Port generator
	_hb_random_port() {
		# Generate random port
			hb_random_port=(`shuf -i 40000-65000 -n 1`)
		# Show random port
			_header "${sysd_name} - Randomizing port"
			_warning ${hb_random_port}
		# Update config.raw
		_note "Updating config.raw - hb_random_port : ${hb_random_port}"
			sed -i "s/hb_random_port/${hb_random_port}/g" ${hb_config_tmp}
		_sep
	}
#------------------------------------------------------------------------------#
# HomeBridge Server Random Port generator
	_hb_server_port() {
		# Generate random port
			hb_server_port=(`shuf -i 40000-65000 -n 1`)
		# Show random port
			_header "${sysd_name} - Randomizing port"
			_warning ${hb_server_port}
		# Update config.raw
			_note "Updating config.raw - hb_server_port : ${hb_server_port}"
				sed -i "s/hb_server_port/${hb_server_port}/g" ${hb_config_tmp}
			_sep
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
		sed -i "s/hb_pin_code/${hb_pin_code}/g" ${hb_config_tmp}
	}
#------------------------------------------------------------------------------#
# HomeBridge config.json Create
	_hb_config_json_install() {
			_header "Preforming cleanup - ${hb_config_tmp} to ${hb_config_json}"
			sudo cat ${hb_config_tmp} | python -m json.tool > ${hb_config_json}
			cat ${hb_config_json}
			_sep
			#sudo rm -rf ${hb_config_tmp}
			_success "Created ${hb_config_json}"
	}
#------------------------------------------------------------------------------#
# Homebridge Create json config
	_hb_config_install() {
		# HomeBridge Node Name
			_hb_sysd_name
			_sep
			_note "${sysd_name}"
			_sep
		# Setup config temp file
			_hb_config_json_setup
		# Create config.raw file
			_hb_config_json_tmp
		# HomeBridge Node Name
			_hb_node_name
		# HomeBridge Node Manufacturer
			_hb_node_man
		# Homebridge Device name
			_hb_node_device_name
		# Create Random Username
			_hb_user_id
		# Create random Port
			_hb_random_port
		# Create random Port
			_hb_server_port
		# Create randon pin
			_hb_pin_code
		# Create config.json file
			_hb_config_json_install
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
