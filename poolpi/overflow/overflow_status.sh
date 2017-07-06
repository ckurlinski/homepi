#!/bin/bash
overflow_status_cmd_fn() {
  node -pe 'JSON.parse(process.argv[1]).status' "$(curl -s 127.0.0.1:3000/circuit/3)"
}
overflow_status_cmd_fn
