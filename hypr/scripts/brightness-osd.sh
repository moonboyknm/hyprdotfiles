#!/bin/sh
# SwayNC transient brightness OSD
case "$1" in
  up) brightnessctl s +10% ;;
  down) brightnessctl s 10%- ;;
esac

value=$(brightnessctl -m | awk -F, '{gsub("%","",$4); print $4}')
notify-send -u low -i display-brightness-symbolic \
  -h string:x-canonical-private-synchronous:brightness \
  -h int:value:"$value" "Brightness" "${value}%"
