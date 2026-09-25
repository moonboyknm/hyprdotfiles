#!/bin/sh
# SwayNC transient volume OSD
case "$1" in
  up) pamixer -i 5 ;;
  down) pamixer -d 5 ;;
  mute) pamixer -t ;;
esac

volume=$(pamixer --get-volume)
if [ "$(pamixer --get-mute)" = "true" ]; then
  icon="audio-volume-muted"
  text="Muted"
else
  icon="audio-volume-high"
  text="${volume}%"
fi

notify-send -u low -i "$icon" -h string:x-canonical-private-synchronous:volume \
  -h int:value:"$volume" "Volume" "$text"
