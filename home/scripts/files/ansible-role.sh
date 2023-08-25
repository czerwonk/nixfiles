#!/bin/bash
set -e

role_name=$1
shift

ansible -m include_role -a "name=$role_name" $@
