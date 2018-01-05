#!/bin/bash
#------------------------------------------------------------------------------#
## Include source files
  source base/base_script.sh
#------------------------------------------------------------------------------#
# Execute set color function
  _set_colors
#------------------------------------------------------------------------------#
## _script_list ##
# Create list of file to search
  _script_list() {
    find . -type f -name "*.sh" \
        ! -path "./.git/*" \
        ! -name "incl.sh" \
        ! -name "misc.sh" \
        ! -name "menu.sh"
  }
#------------------------------------------------------------------------------#
## _config_list ##
# Create list of file to search
  _config_list() {
    find . -type f -name "*.conf" \
        ! -path "./.git/*" 
  }
#------------------------------------------------------------------------------#
## _get_function_list_descrption ##
# Get a list of all functions and descriptions
  _get_function_list_descrption() {
    _header "List of all functions and descriptions"
    _sep
    _script_list | xargs \
      awk '/##/ && /[a-z]/ && /##/ {
        gsub(/##/,"",$0)
        print "File : "FILENAME
        print"\tFunction:\t"$0
        getline
        gsub(/#/,"",$0)
        print"\tDescription:\t"$0
      }'
  }
#------------------------------------------------------------------------------#
## _get_config_list_descrption ##
# Get a list of all config variables and descriptions
  _get_config_list_descrption() {
    _header "Listing all config variables and descriptions"
    _sep
    _config_list | xargs \
      awk '/##/ && /[a-z]/ && /##/ {
        gsub(/##/,"",$0)
        print "File : "FILENAME
        print "\tVariable:\t"$0
        getline
        gsub(/#/,"",$0)
        print"\tDescription:\t"$0
      }'
  }
#------------------------------------------------------------------------------#
## _display_function ##
# Get a list of all functions and descriptions
  _display_function() {
    _create_function_list
    _function_file=$(_script_list | xargs \
        grep -o "## ${_selected} ##" | \
        awk 'BEGIN {FS=":"}{print$1}')
    _header "File name : ${_function_file}"
      awk -v f=${_selected} 'BEGIN {RS="#---"} {
        if ($0 ~ "## "f" ##") {
          print substr($0, index($0,$2))
        }
      }' ${_function_file}
  }
#------------------------------------------------------------------------------#
## _display_variable ##
# Get a list of all functions and descriptions
  _display_variable() {
    _create_variable_list
    _variable_file=$(_config_list | xargs \
        grep -o "## ${_selected} ##" | \
        awk 'BEGIN {FS=":"}{print$1}')
    for i in ${_variable_file[@]}; do
    _header "File name : $i"
      awk -v f=${_selected} 'BEGIN {RS="#---"} {
        if ($0 ~ "## "f" ##") {
          print substr($0, index($0,$2))
        }
      }' $i
    done
  }
#------------------------------------------------------------------------------#
## _create_function_list ##
# Get a list of all functions and descriptions
  _create_function_list() {
    _select "Select Function"
    _l0=( `_script_list | xargs \
        awk '/##/ && /[a-z]/ && /##/ {
        gsub(/##/,"",$0)
        print
        }'
        ` )
    _list_template
    _selected=${_list_output}
    _success "${_selected}"
  }
#------------------------------------------------------------------------------#
## _create_variable_list ##
# Get a list of all variables and descriptions
  _create_variable_list() {
    HEADING="Select Function"
    _l0=( `_config_list | xargs \
        awk '/##/ && /[a-z]/ && /##/ {
        gsub(/##/,"",$0)
        print
        }'
        ` )
    _list_template
    _selected=${_list_output}
    _success "${_selected}"
  }
#------------------------------------------------------------------------------#
## _misc_menu ##
# Misc Menu
  _misc_menu()  {
  		HEADING="HomePi"
      # Menu listing
  			l0=(
  				"Display Functions and Descriptions"
  				"Display Function Code"
          "List all scripts in present working directory"
          "List all config files in present working directory"
          "List variables in all config files"
          "Display Selected Variable"
  				"Exit"
  			)
      # Command map
  			opt0=(
  				'_get_function_list_descrption'
  				'_display_function'
          '_script_list'
          '_config_list'
          '_get_config_list_descrption'
          '_display_variable'
  				'exit'
  				)
      # Execute Menu
        _g_menu_fn
  }
#------------------------------------------------------------------------------#
_misc_menu