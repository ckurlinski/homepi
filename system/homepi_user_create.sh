#!/bin/bash
#------------------------------------------------------------------------------#
# HomePi User Setup
	_homepi_user_setup() {
        _user_name=${g_user}
        _system_user_check
        case ${_user_status} in
            0) _success "User: ${_user_name} exists.....";;
            1) _header "Create ${_user_name} - (y|N)?"
				read _ans
				case ${_ans} in
					y) _system_user_create ;;
					*) _warning "Aborting creating ${_user_name}....";;
				esac ;;
        esac
    }
#------------------------------------------------------------------------------#
# HomePi Group Setup
    _homepi_group_setup() {
        _system_group_check
		if [ $(id -nG ${_user_status} | grep -c ${_group_name}) == 0 ]; then
			_error "${_user_status} is not a member of ${_group_name}"
			_header "Adding ${_user_status} to the ${_group_name} group"
				sudo usermod -G ${_group_name} ${_user_status}
			_success "Added ${_user_status} to the ${_group_name} group"
		else
			_success "User ${_user_status} is already member of gpio group"
		fi
	}