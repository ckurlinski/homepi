#!/bin/bash
overflow_on_cmd_fn() {
  curl -s 127.0.0.1:3000/circuit/2/toggle
}
overflow_on_cmd_fn
