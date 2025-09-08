#!/usr/bin/env sh

cmd=$1
propk=$2
propv=$3

con_id=$(swaymsg -t get_tree | jq -r '
recurse(.nodes[]?, .floating_nodes[]?)
| select(.type == "con")
| select('"${propk}"' == "'"${propv}"'")
| .id
')

if [ -z "${con_id}" ]; then
  swaymsg exec "${cmd}"
else
  swaymsg "[con_id=${con_id}]" focus
fi
