#!/bin/bash
overflow_off_cmd_fn() {
  curl -s 127.0.0.1:3000/circuit/2/toggle
}
overflow_off_cmd_fn
