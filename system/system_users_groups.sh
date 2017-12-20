#!/bin/bash
#------------------------------------------------------------------------------#
# Test if superuser
	_su_test() {
		if [ "$EUID" -ne 0 ]; then
			_note "Using $(whoami) to do the homepi install"
		else
			_sep
			_error "Permissions issue"
			_note "If running as root, all installations and services must run as root"
			_sep
			exit
		fi
	}
#------------------------------------------------------------------------------#
# Test if sudo package is installed
	_sudo_test() {
		_dpkg="sudo"
		_header "Testing if ${_dpkg} is installed"
		dpkg_check
		case ${_pkg} in
			1) _success "${_dpkg} is installed";;
			0) _warning "${_dpkg} is not Installed, Aborting...."
				exit ;;
		esac
	}
#------------------------------------------------------------------------------#
# Test if current user is in the sudoers file
	_sudoers_test() {
		if [ "$EUID" -eq 0 ]; then
			_warning "Not recommeneded to run as root, continue ( y | N )"
			read _ans
			case ${_ans} in
				y) _warning "Continue at your own peril .....";;
				*) _success "Good Call"
					exit ;;
			esac
		else
			_header "Test if current user is in sudoers file"
			if [[ $(getent group sudo | grep $(whoami) 1>/dev/null || echo -1) -ge 0 ]]; then 
				_success "$(whoami) is in the sudo group"
			else
				_warning "$(whoami) is not in the sudo group, aborting...."
			exit
			fi
		fi	
	}
#------------------------------------------------------------------------------#
# System user check - Input ${_user_name} variable - Output ${_user_status}
    _system_user_check() {
        if [[ $(getent passwd ${_user_name} >/dev/null || echo -1) -ne 0 ]]; then
            _user_status=0
        else
            _user_status=1
        fi
    }
#------------------------------------------------------------------------------#
# System user create - Input ${_user_name} variable
    _system_user_create() {
        _header "Creating user - ${_user_name}"
        _note "This is a system account with no home folder or password"
        sudo useradd -M --system ${_user_name}
        _system_user_check
        case ${_user_status} in
            0) _success "${_user_name} created" ;;
            1) _warning "${_user_name} not created";;
        esac
    }
#------------------------------------------------------------------------------#
# System group check - Input ${_group_name} variable - Output ${_group_status}
    _system_group_check() {
        if [[ $(getent group ${_group_name} >/dev/null || echo -1) -ne 0 ]]; then
            _group_status=0
        else
            _group_status=1
        fi
    }
#------------------------------------------------------------------------------#
# System group create - Input ${_group_name} variable
    _system_group_create() {
        _header "Creating system group - ${_group_name}"
        sudo groupadd ${_group_name}
        _system_group_check
        case ${_group_status} in
            0) _success "${_group_name} created" ;;
            1) _warning "${_group_name} not created";;
        esac
    }