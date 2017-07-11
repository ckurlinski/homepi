#!/bin/bash

#------------------------------------------------------------------------------#
# Make script_cmd_dir Directory
# pass var script_cmd_dir
_cmd2_script_dir() {
  if [[ -d ${script_cmd_dir} ]]; then
    _warn "Directory exists: Removing"
      sudo rm -rf ${script_cmd_dir}
    _sep
    _header "Creating new ${script_cmd_dir}"
      sudo mkdir ${script_cmd_dir}
    _sep
}
#------------------------------------------------------------------------------#
# Generate cmdswitch2 script from ${_list0} array
# pass var _cmd_script
_cmd2_scripts_gen() {
    _header "Installing scripts : ${script_cmd_dir}/${_cmd_script}"
    for i in "${_list0[@]}"; do
      sudo echo $i >> ${script_cmd_dir}/${_cmd_script}
    done
    _success ${script_cmd_dir}/${_cmd_script}
    _sep
    cat ${script_cmd_dir}/${_cmd_script}
    _sep
    _note "Press the Any Key to continue..."
    read huh
}
#------------------------------------------------------------------------------#
# Set ownership and permissions on cmdswitch2 script
# Pass var _cmd_script
_cmd2_script_perms() {
  # Set permissions on script
    _header "Setting +x permission : ${script_cmd_dir}/${_cmd_script}"
    sudo chmod +x ${script_cmd_dir}/${_cmd_script}
    _success "+x permission - ${script_cmd_dir}/${_cmd_script}"
    _sep
  ## Set ownership on script
    _header "Setting ownership ${g_user}:${g_group} - ${script_cmd_dir}/${_cmd_script}"
    sudo chown ${g_user}:${g_group} ${script_cmd_dir}/${_cmd_script}
    _success "Set ownership - ${script_cmd_dir}/${_cmd_script}"
    _sep
}
#------------------------------------------------------------------------------#
# Create symbolic link to system bin folder
# Pass var _cmd_script
_cmd2_script_sym() {
  # Create symbolic link
    _header "Creating symbolic links to ${sys_bin} - ${script_cmd_dir}/${_cmd_script}"
    sudo update-alternatives --install "${sys_bin}${_cmd_script}" "${_cmd_script}" "${script_cmd_dir}/${_cmd_script}" 1
    _success "symbolic links - ${script_cmd_dir}${_cmd_script}"
}
#------------------------------------------------------------------------------#
# Set ownership and permission on symbolic link in system bin folder
# Pass var _cmd_script
_cmd2_script_sym_per() {
  # Set ownership on system bin script
    _header "Setting ownership ${g_user}:${g_group} - ${sys_bin}/${_cmd_script}"
    sudo chown ${g_user}:${g_group} ${sys_bin}/${_cmd_script}
    _success "Set ownership - ${sys_bin}/${_cmd_script}"
    _sep
}
