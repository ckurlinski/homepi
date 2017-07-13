#!/bin/bash
#------------------------------------------------------------------------------#
# Clone Git repo
  _get_repo() {
		cd ${g_mod_dir}
		_success "$(pwd)"
		_sep
		if [[ -z $(find . -type d -name ${git_name}) ]]; then
			_header "Cloning ${git_name} into $(pwd)"
				git clone ${git_repo}
				cd ${git_name}
			_sep
			_success "$(cat LICENSE)"
			_sep
			_note "Hit the Any Key to continue....."
				read huh
		else
				cd ${git_name}
			_sep
			_success "$(cat LICENSE)"
			_sep
			_note "Hit the Any Key to continue....."
				read huh
		fi
  }
#------------------------------------------------------------------------------#
# Git checkout branch
  _get_branch() {
		_header "Entering global node install directory: ${g_mod_dir}/${git_name}"
			cd ${g_mod_dir}/${git_name}
		_success "$(pwd)"
		_sep
		_header "Checking out - ${git_name}:${git_branch}"
	    git checkout ${git_branch}
		_sep
  }
#------------------------------------------------------------------------------#
# Install software
	_nodejs_software_install() {
		_header "Installing ${git_name}"
			cd ${g_mod_dir}/${git_name}
			_success "$(pwd)"
		_sep
			${g_npm_install} --silent > /dev/null
		_success "${git_name} installed"
		_sep
	}
#------------------------------------------------------------------------------#
# Creating npm global executable
	_npm_create_executable() {
		if [[ -f "${g_cmd_path}" ]]; then
			_success "${g_cmd_path} is already Created"
		else
			_header "Creating executable ${g_cmd_path}"
			echo ${npm_start_cmd} > ${g_cmd_path}
			_success "${g_cmd_path} Created"
		fi
		## Make file executable
			_header "Making ${g_cmd_path} executable"
			chmod +x ${g_cmd_path}
			_success "${g_cmd_path} made executable"
	}
#------------------------------------------------------------------------------#
# Creating systemd executable
	_npm_create_sysd_exec() {
			_header "Creating symbolic link"
			_note "${g_cmd_path} to ${sysd_cmd_path}"
			sudo update-alternatives --install "${sysd_cmd_path}" "${sysd_name}" "${g_cmd_path}/${sysd_name}" 1
			_success "${sysd_name}"
	}
