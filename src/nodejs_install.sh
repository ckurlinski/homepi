#!/bin/bash

source homepi.conf
source base_script.sh
source cmd_install.sh
source homebridge_install.sh
source homebridge_service_install.sh
source nodejs_install.sh
source system_update.sh

# Install NodeJS
	_node_install() {
		## Download NodeJS and extract
			_header "Downloading ${_node_ver}"
			wget -q ${_node_ver}
			_success "Downloaded ${_node_ver}"
			## Moving NodeJS to system dir
			_header "Moving ${_node_file} to ${_node_dir}"
			sudo mv ${_node_file} ${_node_dir}
			_success "Moved ${_node_file} to ${_node_dir}"
			## Extracting NodeJS to system dir
			_header "Extracting ${_node_file} to ${_node_dir}"
			tar xJf ${_node_file} --strip=1
			_success "${_node_file} Extracted"
		## remove tmp files / folders
			_header "Removing tmp file : ${_node_file}"
			sudo rm -rf ${_node_file}
			_removed "Removed - ${_node_file}"
	}
