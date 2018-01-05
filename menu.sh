#!/bin/bash
#------------------------------------------------------------------------------#
# System Menu
  _system_menu()  {
  		HEADING="System Menu"
      # Menu listing
  			l0=(
  				"Update Raspbian Base System"
  				"Install Dependencies"
  				"NodeJS install"
  				"Return"
  			)
      # Command map
  			opt0=(
  				'_system_update'
  				'_system_depends_install'
  				'_nodejs_install'
  				'main_menu'
  				)
      # Execute Menu
        _g_menu_fn
  }
#------------------------------------------------------------------------------#
## _nodejs_menu ##
# NodeJS Menu
  _nodejs_menu()  {
  		HEADING="NodeJS Menu"
      # Menu listing
  			l0=(
  				"NodeJS Install"
          "npm package tree"
          "npm package install"
  				"Return"
  			)
      # Command map
  			opt0=(
  				'_nodejs_install'
          '_npm_package_info'
          '_npm_installer'
  				'main_menu'
  				)
      # Execute Menu
        _g_menu_fn
  }
#------------------------------------------------------------------------------#
## _homebridge_menu ##
# HomeBridge Menu
  _homebridge_menu()  {
  		HEADING="Homebridge Menu"
      # Menu listing
  			l0=(
  				"Install systemd Homebridge service files"
          "Homebridge Configuration Install"
          "Install HomeBridge systemd services"
  				"Return"
  			)
      # Command map
  			opt0=(
  				'_hb_install_main'
          '_hb_config_install'
          '_homebridge_service_install'
  				'main_menu'
  				)
  	   # Execute Menu
        _g_menu_fn
  }
#------------------------------------------------------------------------------#
## _pool_menu ##
# Pool Menu
  _pool_menu()  {
  		HEADING="Pool Controller"
      # Menu listing
  			l0=(
  				"Nodejs-poolController install"
  				"nodejs-poolController service setup"
  				"Return"
  			)
      # Command map
  			opt0=(
  				'_pool_controller_install'
  				'_pool_controller_service_install'
  				'main_menu'
  				)
      # Execute Menu
        _g_menu_fn
  }
#------------------------------------------------------------------------------#
## _systemd_menu ##
# systemd service management menu
  _systemd_menu()  {
  		HEADING="Systemd Services"
      # Menu listing
  			l0=(
  				"service status"
          "restart service"
          "enable service"
          "disable service"
          "start service"
          "stop service"
          "daemon reload"
					"view daemon config"
  				"Return"
  			)
      # Command map
  			opt0=(
  				'_sysd_service_status'
          '_sysd_service_restart'
          '_sysd_service_enable'
          '_sysd_service_disable'
          '_sysd_service_start'
          '_sysd_service_stop'
          '_sysd_reload_daemon'
					'_sysd_view_unit_file'
  				'main_menu'
  				)
      # Execute Menu
        _g_menu_fn
  }
#------------------------------------------------------------------------------#
## _main_menu ##
# Main Menu
  _main_menu()  {
  		HEADING="HomePi"
      # Menu listing
  			l0=(
  				"System Menu"
  				"NodeJS and npm"
          "Homebridge Menu"
  				"Pool PI Menu"
  				"System Service"
  				"Exit"
  			)
      # Command map
  			opt0=(
  				'_system_menu'
  				'_nodejs_menu'
          '_homebridge_menu'
  				'_pool_menu'
  				'_systemd_menu'
  				'exit'
  				)
      # Execute Menu
        _g_menu_fn
  }
#------------------------------------------------------------------------------#