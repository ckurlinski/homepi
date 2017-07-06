#!/bin/bash
overflow_on_cmd_fn() {
  curl -s 127.0.0.1:3000/circuit/3/toggle > /dev/null
}
overflow_on_cmd_fn
