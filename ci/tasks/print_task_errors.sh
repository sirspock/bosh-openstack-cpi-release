#!/usr/bin/env bash

set -e

source bosh-cpi-src-in/ci/tasks/utils.sh

: ${bosh_admin_password:?}

metadata=terraform-bats/metadata

export_terraform_variable "director_public_ip"

echo 'Printing debug output of tasks in state error'

cd bosh-cpi-src-in/ci/ruby_scripts
bosh -n target ${director_public_ip}
bosh -n login admin ${bosh_admin_password}
bosh -n tasks recent --no-filter 100 | ./print_task_debug_output.sh
