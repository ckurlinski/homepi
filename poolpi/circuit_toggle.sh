#!/bin/bash

circuit_toggle_fn () {
  circuit_select_fn
  _status=(`node -pe 'JSON.parse(process.argv[1]).status' "$(curl -s ${_server_ip}:${_server_port}/circuit/${_circuit})"`)
  if [[ ${_status} == 0 ]]; then
    _select "Turning Circuit ${_circuit} - ON"
  else
    _select "Turning Circuit ${_circuit} - OFF"
  fi
  curl -s ${_server_ip}:${_server_port}/circuit/${_circuit}/toggle
  pool_menu
}
