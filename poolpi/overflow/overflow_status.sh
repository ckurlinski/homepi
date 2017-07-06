#!/bin/bash
overflow_status_cmd_fn() {
  _status=(`node -pe 'JSON.parse(process.argv[1]).status' "$(curl -s 127.0.0.1:3000/circuit/3)"`)
  if [[ ${_status} == 0 ]]; then
    echo "0"
  else
    echo "1"
  fi
}
overflow_status_cmd_fn
