#!/bin/bash
# Run iperf3 -s on target

blank() { [[ -z $1 ]]; }

if blank "$2"; then
  port="-p 5201"
else
  port="-p $2"
fi


target=${1:-nuc.local}
dir=$target/$(date -u +%Y-%m-%d)/$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
mkdir -p "$dir" || true
iperf3 -J -c "$target" "$port" > "$dir"/"$(date +%s)".json
