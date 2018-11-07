#!/bin/bash

set -u

systemd_list() {
  [[ $# -lt 1 ]] && { printf "No search string provided\n"; exit 2; }
  OLD_IFS=$IFS
  IFS=$'\n'
  SERVICE_LIST=$(systemctl list-unit-files --type=service | grep -i ${1})
  for s in ${SERVICE_LIST}; do
    echo ${s}
  done
  IFS=${OLD_IFS}
}

[[ ${EUID} -ne 0 ]] && { return 1; }

# All: "^.*$"
# redis: redis

systemd_list redis
