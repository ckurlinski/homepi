#!/bin/bash

source homepi.conf
source src/base_script.sh
source src/cmd_install.sh
source src/homebridge_install.sh
source src/homebridge_service_install.sh
source src/nodejs_install.sh
source src/system_update.sh

# Install cmdlets scripts
	_faac_door_scripts_install() {
		## Files to be created
			_file1="door_open.sh"
			_file2="door_close.sh"
		## Make cmdlets Directory
			sudo mkdir ${_cmdaccessory_cmdlets}
		## open door script template
			_list0=(
				"#!/bin/bash"
				"gpio -p write 200 1"
				"sleep 2"
				"gpio -p write 200 0"
			)
		## Install open door script
			_header "Installing FAAC door scripts : ${_cmdaccessory_cmdlets}/${_file1}"
			for i in "${_list0[@]}"; do
				sudo echo $i >> ${_cmdaccessory_cmdlets}/${_file1}
			done
			_success ${_cmdaccessory_cmdlets}/${_file1}
		## Show open door script
			_sep
			cat ${_cmdaccessory_cmdlets}/${_file1}
			_sep
		## close door script template
			_list0=(
				"#!/bin/bash"
				"gpio -p write 200 1"
				"sleep 2"
				"gpio -p write 200 0"
			)
		## Install close door script
			_header "Installing FAAC door scripts : ${_cmdaccessory_cmdlets}/${_file2}"
			for i in "${_list0[@]}"; do
				sudo echo $i >> ${_cmdaccessory_cmdlets}/${_file2}
			done
			_success ${_cmdaccessory_cmdlets}/${_file2}
		## Show close door script
			_sep
			cat ${_cmdaccessory_cmdlets}/${_file2}
			_sep
		## Set permissions on open door script
			_header "Setting +x permission : ${_cmdaccessory_cmdlets}/${_file1}"
			sudo chmod +x ${_cmdaccessory_cmdlets}/${_file1}
			_success "+x permission - ${_cmdaccessory_cmdlets}/${_file1}"
		## Set permissions on close door script
			_header "Setting +x permission : ${_cmdaccessory_cmdlets}/${_file2}"
			sudo chmod +x ${_cmdaccessory_cmdlets}/${_file2}
			_success "+x permission - ${_cmdaccessory_cmdlets}/${_file2}"
		## Create symbolic links on open door script
			_header "Creating symbolic links to /usr/bin - ${_cmdaccessory_cmdlets}/${_file1}"
			sudo update-alternatives --install "/usr/bin/${_file1}" "${_file1}" "${_cmdaccessory_cmdlets}/${_file1}" 1
			_success "symbolic links - ${_cmdaccessory_cmdlets}${_file1}"
		## Create symbolic links on closed door script
			_header "Creating symbolic links to /usr/bin - ${_file2}"
			sudo update-alternatives --install "/usr/bin/${_file2}" "${_file2}" "${_cmdaccessory_cmdlets}/${_file2}" 1
			_success "symbolic links - ${_cmdaccessory_cmdlets}/${_file2}"
	}
