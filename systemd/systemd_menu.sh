#!/bin/bash

# systemd service management menu
	systemd_menu()  {
		## Header
			HEADING="systemd service management"
		## Write out the menu options array
			### Use Double Quotes for Text
				l0=(
					"systemd service status"
          "systemd service restart"
          "systemd service enable"
          "systemd service disable"
          "systemd service start"
          "systemd service stop"
          "systemd daemon reload"
					"Return"
				)
		## Map Menu to command Array
			### Use Single Quotes for Commands
				opt0=(
					'_systemd_service_status'
          '_systemd_service_restart'
          '_systemd_service_enable'
          '_systemd_service_disable'
          '_systemd_service_start'
          '_systemd_service_stop'
          '_systemd_reload_daemon'
					'main_menu'
					)
		## Execute Menu Function
			g_menu_fn
	}
