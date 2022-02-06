#!/bin/bash
BINFO=$(acpi | sed s/,//g)
STATE=$( echo $BINFO | awk '{ print $3 }' )
PER=$( echo $BINFO | awk '{ print $4 }' | sed 's/[^0-9]*//g' )

if [ $STATE == "Discharging" ]; then
  TIMELEFT=$( echo $BINFO | awk '{ print $5 }')
  # Separate hours and minutes (leave off seconds) and remove leading zero from hours:
  H="$(echo $TIMELEFT | cut -d':' -f1 | sed 's/^0//' )"
  M="$(echo $TIMELEFT | cut -d':' -f2)"
  echo " | ${PER}% (${H}:${M})"

else
  if [ "$PER" -lt 95 ]; then
    echo " | ${PER}%"
  fi
fi
