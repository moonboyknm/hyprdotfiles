#!/bin/sh
# SwayNC transient keyboard-backlight OSD
case "$1" in
  up) brightnessctl -d '*::kbd_backlight' s +10% ;;
  down) brightnessctl -d '*::kbd_backlight' s 10%- ;;
esac

value=$(brightnessctl -m -d '*::kbd_backlight' | awk -F, '{gsub("%","",$4); print $4}')
notify-send -u low -i input-keyboard \
  -h string:x-canonical-private-synchronous:keyboard-backlight \
  -h int:value:"$value" "Keyboard Backlight" "${value}%"
