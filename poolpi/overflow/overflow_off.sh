#!/bin/bash
overflow_off_cmd_fn() {
  curl -s 127.0.0.1:3000/circuit/3/toggle > /dev/null
}
overflow_off_cmd_fn
