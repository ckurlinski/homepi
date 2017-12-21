#!/bin/bash
#------------------------------------------------------------------------------#
## _homepi_user_setup ##
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
## _homepi_group_setup ##
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
#------------------------------------------------------------------------------#
# HomePi User folder Setup
#------------------------------------------------------------------------------#
## _homepi_install_folder_setup ##
# HomePi install folder Setup
	_homepi_install_folder_setup() {
		_note "Setting npm global user:group to ${g_user}:${g_group}"
			sudo chown -R ${g_user}:${g_group} ${g_node_dir}/{lib/node_modules,bin,share}
		_success "Running scripts as ${g_user}:${g_group}"
	}
#------------------------------------------------------------------------------#
## _sym_link_homepi ##
# Create symbolic link in ${g_node_dir} to homepi
	_sym_link_homepi() {
		if [[ -e "${g_node_dir}/bin/homepi" ]]; then
			if [[ -e $(readlink -f ${g_node_dir}/bin/homepi) ]]; then
				echo "========================================"
				echo "Welcome to HomePi"
				echo "========================================"
			else
				sudo rm ${g_node_dir}/bin/homepi
				sudo ln -s $(pwd)/homepi ${g_node_dir}/bin/homepi
				if [[ -e "${g_node_dir}/bin/homepi" ]]; then
					sudo chmod 755 ${g_node_dir}/bin/homepi
				fi
			fi
		else
			sudo ln -s $(pwd)/homepi ${g_node_dir}/bin/homepi
				if [[ -e "${g_node_dir}/bin/homepi" ]]; then
					sudo chmod 755 ${g_node_dir}/bin/homepi
				fi
			echo "========================================"
			echo "Welcome to HomePi"
			echo "========================================"
		fi
	}
#------------------------------------------------------------------------------#