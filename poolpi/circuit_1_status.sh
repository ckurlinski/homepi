#!/bin/bash

if [[ -z $1 ]]; then
  echo "Missing circuit Number. Goodbye"
  exit
fi

_server_ip="192.168.1.66"
_server_port="3000"
_circuit=$1

circuit_status_fn () {
  #"curl -s http://${_server_ip}:${_server_port}/circuit/${_circuit}"
  _status=(`node -pe 'JSON.parse(process.argv[1]).status' "$(curl -s ${_server_ip}:${_server_port}/circuit/${_circuit})"`)
  if [[ ${_status} == 0 ]]; then
    echo "Circuit ${_circuit} status is off"
  else
    echo "Circuit ${_circuit} status is on"
  fi
}
circuit_status_fn
