#!/bin/bash
vac_on_cmd_fn() {
  curl -s 127.0.0.1:3000/circuit/2/toggle > /dev/null
}
vac_on_cmd_fn
