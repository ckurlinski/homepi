#!/bin/bash

# Install NodeJS
	_nodejs_install() {
		## Download NodeJS and extract
			_header "Downloading ${node_link}"
			wget -q ${node_link}
			_success "Downloaded ${node_link}"
		## Extracting NodeJS to system dir
			_header "Extracting ${node_file} to ${g_node_dir}"
			tar xJf ${node_file} --strip=1
			_success "${node_file} Extracted"
		## remove tmp files / folders
			_header "Removing tmp file : ${node_file}"
			sudo rm -rf ${node_file}
			_removed "Removed - ${node_file}"
	}
