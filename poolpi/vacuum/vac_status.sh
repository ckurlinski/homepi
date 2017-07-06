#!/bin/bash
vac_status_cmd_fn() {
  _status=(`node -pe 'JSON.parse(process.argv[1]).status' "$(curl -s 127.0.0.1:3000/circuit/2)"`)
  if [[ ${_status} == 0 ]]; then
    echo ""
  else
    echo "1"
  fi
}
vac_status_cmd_fn
