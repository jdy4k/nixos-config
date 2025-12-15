#! /usr/bin/env bash

open_overview() {
  hyprctl keyword decoration:inactive_opacity 0.8
  hyprctl keyword decoration:active_opacity 0.8
  hyprctl dispatch overview:open

  while read -r line; do
    if [[ $line == "overview:closed" ]]; then
      sleep 0.2
      hyprctl keyword decoration:inactive_opacity 1.0
      hyprctl keyword decoration:active_opacity 1.0
      break
    fi
  done < <(
    socat - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket3.sock
  )
}

open_overview
