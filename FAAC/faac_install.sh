#!/bin/bash
#------------------------------------------------------------------------------#
# Install FAAC door open into script_cmd_dir
	_faac_door_open_script_gen() {
		# File to be created
			_cmd_script="door_open.sh"
		# open door script template
			_list0=(
				"#!/bin/bash"
				"gpio -p write 200 1"
				"sleep 2"
				"gpio -p write 200 0"
			)
		# Generate script from _list0 array
			_cmd2_scripts_gen
		# Set Permission on script
			_cmd2_script_perms
		# Create symbolic link
			_cmd2_script_sym
		# Set ownership and permissions on symbolic link
			_cmd2_script_sym_per
	}
#------------------------------------------------------------------------------#
# Install FAAC door open into script_cmd_dir
	_faac_door_close_script_gen() {
		# File to be created
			_cmd_script="door_close.sh"
		# close door script template
			_list0=(
				"#!/bin/bash"
				"gpio -p write 200 1"
				"sleep 2"
				"gpio -p write 200 0"
			)
		# Generate script from _list0 array
			_cmd2_scripts_gen
		# Set Permission on script
			_cmd2_script_perms
		# Create symbolic link
			_cmd2_script_sym
		# Set ownership and permissions on symbolic link
			_cmd2_script_sym_per
	}
## FAAC Installation
	_faac_install() {
		# Create script directory
			_cmd2_script_dir
		# Create script - open
			_faac_door_open_script_gen
		# Create script - close
			_faac_door_close_script_gen
	}
