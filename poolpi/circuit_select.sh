#!/bin/bash

circuit_select_fn () {
  _header "Select Circuit Number"
  l0=( 1 2 3 4 5 6 7 8 9 10 )
  list_template
  _circuit=${_list_output}
}
