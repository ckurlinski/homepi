#!/bin/bash
vac_off_cmd_fn() {
  curl -s 127.0.0.1:3000/circuit/2/toggle
}
vac_off_cmd_fn
