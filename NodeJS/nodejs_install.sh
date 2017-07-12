#!/bin/bash

# Choose NodeJS version
	_nodejs_version() {
		_header "Choose NodeJS Version"
		_l0=${nodejs_ver_list}
		_list_template
		nodejs_ver=${_list_output}
		_success "NodeJS Version is: ${nodejs_ver}"
	}
# List NodeJS Downloads
	_nodejs_download_list() {
		_system_os_arch_detect
		_nodejs_version
		_select "Choose NodeJS to download"
		_l0=(`curl -s ${nodejs_web}/${nodejs_ver} \
			| awk 'BEGIN{FS="\"";OFS="\t"}{print$2}' \
			| grep -i ${sys_os} \
			| grep ${sys_arch} \
			| grep tar.xz`)
		_list_template
		node_sel=${_list_output}
		_success ${node_sel}
	}

# Install NodeJS
	_nodejs_install() {
		_nodejs_download_list
		# Download NodeJS and extract
			_header "Downloading ${node_sel}"
			node_file=(`echo ${node_sel} | sed 's/.tar.xz//g'`)
			cd ${g_node_dir}
			sudo wget -q ${nodejs_web}/${nodejs_ver}/${node_sel}
			_success "Downloaded ${node_sel}"
		# Extracting NodeJS to system dir
			_header "Extracting ${node_file} to ${g_node_dir}"
			sudo tar xJf ${node_file} --strip=1
			_success "${node_file} Extracted"
		# remove tmp files / folders
			_header "Removing tmp file : ${node_file}"
			sudo rm -rf ${node_file}
			_removed "Removed - ${node_file}"
	}
