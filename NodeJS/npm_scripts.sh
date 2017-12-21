#!/bin/bash
#------------------------------------------------------------------------------#
## _node_select_package ##
# Select npm package to install
	_node_select_package() {
		_l0=(
			$(cat ${npm_package_file})
		)
		_list_template
		npm_package=${_list_output}
	}
#------------------------------------------------------------------------------#
## _npm_installer ##
# npm packege installler
	_npm_installer() {
		_sep
		_note "If you want to add a npm package, create subfolder, shell scripts,
		and configs for the package
		The items will be automatically added when homepi starts"
		_sep
		_select "Select from npm packages with configs on system"
		_sep
		_node_select_package
		_npm_install
	}
#------------------------------------------------------------------------------#
## _npm_setup ##
# Install a npm
	_npm_setup() {
		## Install nodes
			for i in "${npm_package}"; do
					${g_npm_install} $i
				_success $i
			done
	}
#------------------------------------------------------------------------------#
## _npm_install ##
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
## _npm_install_test ##
# npm installed check
	_npm_install_test() {
		_note "Checking - ${npm_package}"
		npm -g list ${npm_package} > /dev/null \
			&& npm_installed=1 \
			|| npm_installed=0
	}
#------------------------------------------------------------------------------#
## _npm_check_package ##
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
## _npm_package_info ##
# list npm package tree
	_npm_package_info() {
		_select "Select npm package to view"
			_node_select_package
		_sep
		_success "npm package: ${npm_package}"
		_sep
			_npm_check_package
			if [[ ${npm_installed} == 1 ]]; then
				_sep
				_header "npm show information for package: ${npm_package}"
					npm -g ll ${npm_package}
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
## _npm_package_list_gen ##
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
#------------------------------------------------------------------------------#