#!/bin/bash
#------------------------------------------------------------------------------#
# Create symbolic link in ${g_node_dir} to homepi
	_sym_link_homepi() {
		if [[ -e "${g_node_dir}/bin/homepi" ]]; then
			if [[ -e $(readlink -f ${g_node_dir}/bin/homepi) ]]; then
				echo "Welcome to HomePi"
			else
				sudo rm ${g_node_dir}/bin/homepi
				sudo ln -s $(pwd)/homepi ${g_node_dir}/bin/homepi
				if [[ -e "${g_node_dir}/bin/homepi" ]]; then
					sudo chmod 755 ${g_node_dir}/bin/homepi
				fi
			fi
		else
			sudo ln -s $(pwd)/homepi ${g_node_dir}/bin/homepi
				if [[ -e "${g_node_dir}/bin/homepi" ]]; then
					sudo chmod 755 ${g_node_dir}/bin/homepi
				fi
			echo "Welcome to HomePi"
		fi
	}
