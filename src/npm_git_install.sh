#!/bin/bash

# User Setup
	_user_setup() {
		if [ $(getent passwd ${_username}) ]; then
			_header "User: ${_username} exists....."
		else
			_header "Creating ${_username}"
			sudo useradd -M --system ${_username}
			_success "Created ${_username}"
		fi
		# Add user to the gpio group
		if [ $(id -nG ${_username} | grep -c "gpio") == 0 ]; then
			_error "${_username} is not a member of gpio"
			_header "Adding ${_username} to the gpio group"
			sudo usermod -G gpio ${_username}
			_success "Added ${_username} to the gpio group"
		fi
	}

# Clone Git repo
  _get_repo() {
		cd ${_git_node_dir}
		if [[ -z $(find . -type d -name ${_git_node_name}) ]]; then
			sudo git clone ${_git_repo}
		fi
  }

# Git select branch
  _get_branch() {
    cd ${_git_node_name}
    sudo git checkout ${_git_branch}
    sudo git pull
  }

# Install software
	_git_software_install() {
		_header "Installing ${_git_node_name}"
		cd ${_git_node_dir}/${_git_node_name}
		sudo npm install -g --unsafe-perm --silent > /dev/null
		_success "${_git_node_name} installed"
	}
	_git_create_executable() {
		## Creating executable
		if [[ -f "${_git_cmd_dir}/${_systemd_service_name}" ]]; then
			_success "${_git_cmd_dir}/${_systemd_service_name} is already Created"
		else
			_header "Creating executable ${_git_cmd_dir}/${_systemd_service_name}"
			echo ${_npm_start_cmd} > ${_git_cmd_dir}/${_systemd_service_name}
			_success "${_git_cmd_dir}/${_systemd_service_name} Created"
		fi
		## Make file executable
			_header "Making ${_git_cmd_dir}/${_systemd_service_name} executable"
			sudo chmod 755 ${_git_cmd_dir}/${_systemd_service_name}
			_success "${_git_cmd_dir}/${_systemd_service_name} made executable"
		## Create Symbolic Links
			_header "Creating symbolic link to /usr/bin/${_systemd_service_name}"
			sudo update-alternatives --install "/usr/bin/"${_systemd_service_name} "${_systemd_service_name}" "${_git_cmd_dir}/${_systemd_service_name}" 1
			_success "${_systemd_service_name}"
}

# Software Install Main
	_install_git_software_fn() {
		_user_setup
		_get_repo
		_get_branch
    _git_software_install
	}
