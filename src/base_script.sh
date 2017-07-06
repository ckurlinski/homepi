#!/bin/bash

# Test if superuser
	_su_test() {
		# Script must be run as root
		if [ "$EUID" -ne 0 ]; then
			_error "Permissions issue"
			_note "Please run as root or with sudo"
			exit
		fi
	}
# Set Colors
	_set_colors() {
		reset=$(echo -en '\033[0m')
		red=$(echo -en '\033[00;31m')
		green=$(echo -en '\033[00;32m')
		yellow=$(echo -en '\033[00;33m')
		blue=$(echo -en '\033[00;34m')
		magenta=$(echo -en '\033[00;35m')
		purple=$(echo -en '\033[00;35m')
		cyan=$(echo -en '\033[00;36m')
		lightgray=$(echo -en '\033[00;37m')
		lred=$(echo -en '\033[01;31m')
		lgreen=$(echo -en '\033[01;32m')
		lyellow=$(echo -en '\033[01;33m')
		lblue=$(echo -en '\033[01;34m')
		lmagenta=$(echo -en '\033[01;35m')
		lpurple=$(echo -en '\033[01;35m')
		lcyan=$(echo -en '\033[01;36m')
		white=$(echo -en '\033[01;37m')
	}
# Set Print formatting
	## Header
		_header() {
			printf "\n${lcyan}==========  %s  ==========${reset}\n" "$@"
		}
	## Menu selection
		_select() {
			printf "${lgreen}%s${reset}\n" "$@"
		}
	## Seperator
		_sep() {
			printf "\n${lpurple}========================================${reset}\n" "$@"
		}
	## Successful Command
		_success() {
			printf "${green}✔ %s${reset}\n" "$@"
		}
	## Error
		_error() {
			printf "${red}✖ %s${reset}\n" "$@"
		}
	## Successful Removal
		_removed() {
			printf "${green}✖ %s${reset}\n" "$@"
		}
	## Warning
		_warning() {
			printf "${yellow}➜ %s${reset}\n" "$@"
		}
	## Note
		_note() {
			printf "${lyellow}Note:${reset}  ${lyellow}%s${reset}\n" "$@"
		}
	# Null responce check
		_ans_check() {
			while [ -z "${_ans}" ]; do
				_error "null string"
				_header "Re enter value"
				read _ans
			done
		}
# List Template
	list_template() {
	# Script wide listing function
	# Needs "l0" array or other assigned for this to work
	# Sets selection value to "_list_output"
		a=
		count=1
		for c0 in "${l0[@]}"
		do
			a0[$count]=$c0
			echo "$count ${a0[$count]}"
			((count++))
		done
		read c1
			_list_output=${a0[$c1]}
	}
# Menu List Function
	menu_list_template() {
		count=1
		for c0 in "${l0[@]}"
		do
			a0[$count]=$c0
			_select "$count - ${a0[$count]}"
			((count++))
		done
		read c1
		if [[ $c1 = [a-Z] ]]; then
			_error "Bad Input - no donut"
			return 1
		fi
		MENU_COUNT=${c1}
		MENU_OUTPUT=${a0[$c1]}
		opt_count=( `expr ${MENU_COUNT} - 1` )
	}
# Command to run from menu command array
	menu_command_run() {
		${opt0[$opt_count]}
	}
# Generic Base Menu Function
	g_menu_fn() {
		while :
		do
			_header ${HEADING}
			## Generate menu list from menu options array
				menu_list_template
			## Run choosen command from menu command array
				menu_command_run
		done
	}
