#!/bin/bash
#------------------------------------------------------------------------------#
# Select npm package to install
	_node_select_package() {
		_l0=(
			$(awk '{print"\""$0"\""}' ${npm_package_file})
		)
		_list_template
		npm_package=${_list_output}
	}
#------------------------------------------------------------------------------#
# Install a npm
	_npm_setup() {
		## Install nodes
			for i in "${npm_package[@]}"; do
				_header "Installing $i"
					npm install -g --unsafe-perm --silent $i > /dev/null
				_success $i
			done
	}
#------------------------------------------------------------------------------#
# Check to see if npm package is installed
# var ${npm_package} is supplied
	_npm_check_package() {
		npm_test=(`npm -g list ${npm_package} > /dev/null && echo 1 || echo 0`)
		if [[ ${npm_test} == 0 ]]; then
			_sep
			_warning "${npm_package} is not installed"
			_sep
			_select "Install ${npm_package}: (y|n)"
				read _ans
				case ${_ans} in
					y)	_header "Installing ${npm_package}"
							_npm_setup
							if [[ ${npm_test} == 1 ]]; then
								_success "${npm_package} = Installed"
							fi
							npm_installed=1
							;;
					*)	_warning "${npm_package} is not installed"
							npm_installed=0
							;;
				esac
		fi
	}
#------------------------------------------------------------------------------#
# list npm package tree
	_npm_package_tree() {
		_select "Select npm package to view"
			_node_select_package
		_success "npm package: ${npm_package}"
		_sep
			_npm_check_package
			if [[ ${npm_installed} == 1 ]]; then
				_sep
				_header "npm install tree for package: ${npm_package}"
					npm -g list ${npm_package}
				_sep
				_select "Press the Any Key to continue...."
				read huh
			else
				_warning "No npm install tree: ${npm_package} not installed"
				_sep
			fi
	}
#------------------------------------------------------------------------------#
# Generate npm package installation list
# Pulls the var ${npm_package_name} from config files
	_npm_package_list_gen() {
		find . -type f -name "*.conf" \
      ! -path "./.git/*" \
      | sed 's/\.\///g' \
			| xargs grep npm_package_name \
			| awk '{print$2}' \
			| awk 'BEGIN{FS="=";OFS="\t"}{print$2}' \
			| tr -d "\"" > NodeJS/npm_package_list
	}
