#!/bin/bash

# Pool Menu
	pool_menu()  {
		## Header
			HEADING="Pool Controller"
		## Write out the menu options array
			### Use Double Quotes for Text
				l0=(
					"Circuit Status"
					"Circuit Toogle"
					"nodejs-poolController install"
					"nodejs-poolController service setup"
					"Return"
				)
		## Map Menu to command Array
			### Use Single Quotes for Commands
				opt0=(
					'circuit_status_fn'
					'circuit_toggle_fn'
					'_pool_controller_install'
					'_pool_controller_service_install'
					'main_menu'
					)
		## Execute Menu Function
			g_menu_fn
	}
