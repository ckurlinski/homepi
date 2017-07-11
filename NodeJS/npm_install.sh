#!/bin/bash

# Install HomeBridge extra / dependencies
	_node_extras_setup() {
		## List of nodes to install
			node_list=(
				homebridge-gpio-wpi2@latest
				homebridge-cmdaccessory@latest
				homebridge-cmdswitch2@latest
			)
		## Install nodes
			for i in "${node_list[@]}"; do
				_header "Installing $i"
				sudo npm install -g --unsafe-perm --silent $i > /dev/null
				_success $i
			done
	}

## Extra / dependencies Installation
	_npm_extras_install() {
		_node_extras_setup
	}
