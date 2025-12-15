#! /usr/bin/env bash

open_overview() {
  hyprctl keyword decoration:inactive_opacity 0.95
  hyprctl keyword decoration:active_opacity 0.95
  hyprctl dispatch overview:open

  while read -r line; do
    if [[ $line == *"close"* ]]; then
      sleep 0.2
      hyprctl keyword decoration:inactive_opacity 1.0
      hyprctl keyword decoration:active_opacity 1.0
      break
    fi
  done < <( tail -n 0 -f /tmp/overview-events
    
  )
}

if [[ $(tail -1 /tmp/overview-events) == *"open"* ]]; then
	hyprctl dispatch overview:close
else
	open_overview
fi
