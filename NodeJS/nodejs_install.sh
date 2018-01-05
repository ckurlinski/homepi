#!/bin/bash
#------------------------------------------------------------------------------#
## _nodejs_version ##
# Choose NodeJS version
	_nodejs_version() {
		_sep
		_header "Choose NodeJS Version"
		_l0=(
			"latest-v4.x"
			"latest-v5.x"
			"latest-v6.x"
			"latest-v7.x"
			"latest-v8.x"
		)
		_list_template
		nodejs_ver=${_list_output}
		_success "NodeJS Version is: ${nodejs_ver}"
		_sep
	}
#------------------------------------------------------------------------------#
## _nodejs_download_list ##
# List NodeJS Downloads
	_nodejs_download_list() {
		_sep
		_system_os_arch_detect
		_nodejs_version
		# Test system arch if unknown
			if [[ ${sys_arch} == 0 ]]; then
				_warning "Unknown System Arch detected, Aborting....."
			fi
		_select "Choose NodeJS to download"
		_l0=(`curl -s ${nodejs_web}/${nodejs_ver}/ \
			| awk 'BEGIN{FS="\"";OFS="\t"}{print$2}' \
			| grep -i ${sys_os} \
			| grep ${sys_arch} \
			| grep tar.xz`)
		_list_template
		node_sel=${_list_output}
		_success ${node_sel}
	}
#------------------------------------------------------------------------------#
## _nodejs_install ##
# Install NodeJS
	_nodejs_install() {
		_nodejs_download_list
		# Download NodeJS and extract
			_sep
			_header "Downloading ${node_sel}"
			cd ${g_node_dir}
			sudo wget -q ${nodejs_web}/${nodejs_ver}/${node_sel}
			_success "$(ls ${g_node_dir}/${node_sel})"
			_sep
		# Extracting NodeJS to system dir
			_header "Extracting ${node_sel} to ${g_node_dir}"
			sudo tar xJf ${node_sel} --strip=1
			_success "${node_sel} Extracted"
			_sep
		# remove tmp files / folders
			_header "Removing tar.xz : ${node_sel}"
			sudo rm ${node_sel}
			_removed "Removed - ${node_sel}"
			_sep
	}
#------------------------------------------------------------------------------#