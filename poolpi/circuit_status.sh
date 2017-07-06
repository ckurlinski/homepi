#!/bin/bash

circuit_status_fn () {
  circuit_select_fn
  _status=(`node -pe 'JSON.parse(process.argv[1]).status' "$(curl -s ${_server_ip}:${_server_port}/circuit/${_circuit})"`)
  if [[ ${_status} == 0 ]]; then
    echo "Circuit ${_circuit} status is off"
  else
    echo "Circuit ${_circuit} status is on"
  fi
}
