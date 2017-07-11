#!/bin/bash

#------------------------------------------------------------------------------#
# HomeBridge Node Name
	_hb_node_name() {
		_header "Enter name for instance"
		read _ans
		_ans_check
		hb_node_name_var="${_ans}"
		_success "${hb_node_name_var}"
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Description
	_hb_node_desc() {
		_header "Enter description for ${sysd_service} Node"
		read _ans
		_ans_check
		hb_node_desc_var="${_ans}"
		_success "${hb_node_desc_var}"
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Manufacturer
	_hb_node_man() {
		_header "Enter Manufacturer for ${sysd_service} Node"
		read _ans
		_ans_check
		hb_node_man_var="${_ans}"
		_success "${hb_node_man_var}"
	}
#------------------------------------------------------------------------------#
# HomeBridge Node Device Name
	_hb_node_device_name() {
		_header "Enter Device ${sysd_service} Name for Node"
		read _ans
		_ans_check
		hb_node_device_name_var="${_ans}"
		_success "${hb_node_device_name_var}"
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
			hb_user_id_var="${octets}:${octeta}:${octetb}:${octetc}"
			_header "Generating ${sysd_service} Usename"
			_warninging ${hb_user_id_var}
	}
#------------------------------------------------------------------------------#
# HomeBridge Random Port generator
	_hb_random_port() {
		## Generate random port
			hb_random_port_var=(`shuf -i 40000-65000 -n 1`)
		## Show random port
			_header "${sysd_service} - Randomizing port"
			_warninging ${hb_random_port_var}
	}
#------------------------------------------------------------------------------#
# HomeBridge Server Random Port generator
	_hb_server_port() {
		## Generate random port
			hb_server_port_var=(`shuf -i 40000-65000 -n 1`)
		## Show random port
			_header "${sysd_service} - Randomizing port"
			_warninging ${hb_server_port_var}
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
			hb_pin_code_var="${a}${b}${c}-${d}${e}-${f}${g}${h}"
		## Show HomeBridge random pin
			_header "Generating ${sysd_service} access code"
			_warninging ${hb_pin_code_var}
	}
#------------------------------------------------------------------------------#
# HomeBridge config.json setup check
	_hb_config_json_setup() {
		## Stop existing HomeBridge service
			if [ $(sudo ps -aux | grep -c '^${sysd_service}') = 1 ]; then
				_header "Stopping ${sysd_service} Services"
					sudo systemctl stop homebridge
				_removed "Stopping ${sysd_service} Services - Done!"
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
			_header "Preforming cleanup - ${hb_config_tmp} to ${hb_json}"
			sudo cat ${hb_config_tmp} | python -m json.tool > ${hb_json}
			sudo rm -rf ${hb_config_tmp}
			_success "Created ${hb_json}"
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
