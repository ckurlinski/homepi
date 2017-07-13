#!/bin/bash
#------------------------------------------------------------------------------#
# Select npm package to install
	_node_select_package() {
		_l0=(
			$(cat ${npm_package_file})
		)
		_list_template
		npm_package=${_list_output}
	}
#------------------------------------------------------------------------------#
# npm packege installler
	_npm_installer() {
		_select "Select from npm packages with configs on system"
		_note "If you want to add a npm package, create subfolder and configs
for the package"
		_sep
		_node_select_package
		_npm_install
	}
#------------------------------------------------------------------------------#
# Install a npm
	_npm_setup() {
		## Install nodes
			for i in "${npm_package}"; do
					${g_npm_install} $i
				_success $i
			done
	}
#------------------------------------------------------------------------------#
# npm install
	_npm_install() {
		_select "Install ${npm_package}: (y|n)"
			read _ans
		_sep
			case ${_ans} in
				y)	_header "Installing ${npm_package}"
						${g_npm_install} ${npm_package}
						if [[ ${npm_test} == 1 ]]; then
							_success "${npm_package} = Installed"
						fi
						_sep
						npm_installed=1
						;;
				*)	_warning "${npm_package} was not installed, Aborted"
						_sep
						npm_installed=0
						;;
			esac
	}
#------------------------------------------------------------------------------#
# npm installed check
	_npm_install_test() {
		npm -g list ${npm_package} > /dev/null \
			&& npm_installed=1 \
			|| npm_installed=0
	}
#------------------------------------------------------------------------------#
# Check to see if npm package is installed
# var ${npm_package} is supplied
	_npm_check_package() {
		_npm_install_test
		if [[ ${npm_installed} == 0 ]]; then
			_sep
			_error "${npm_package} is not installed"
			_sep
		fi
	}
#------------------------------------------------------------------------------#
# list npm package tree
	_npm_package_tree() {
		_select "Select npm package to view"
			_node_select_package
		_sep
		_success "npm package: ${npm_package}"
		_sep
			_npm_check_package
			if [[ ${npm_installed} == 1 ]]; then
				_sep
				_header "npm install tree for package: ${npm_package}"
					npm -g tree ${npm_package}
				_sep
				_select "Press the Any Key to continue...."
				read huh
			else
				_sep
				_error "No npm install tree: ${npm_package} not installed"
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
