#!/bin/bash

_npm_status_fn() {
  _header "Checking for global npm updates"
    sudo npm -g outdated
}
