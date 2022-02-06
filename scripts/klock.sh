#!/bin/bash
QUITTIN_TIME = 17
if [ $(date '+%H') > $QUITTIN_TIME ] && [ $[ $RANDOM % 3 ] == 0 ] ; then
  time=" | F'it O'Clock"
else
  declare -a N_array
  # N_array=(Oh Uno Too Trez For Fyv Six Sever Ate Noin X Elven 12 )
  N_array=(O I II III IV V VI VII VIII IX X XI XII )

  H=$(date '+%l')
  M=$(date '+%M')
  hour=${N_array[${H}]}

  if (( $M > 40 )); then
    time="Old ${N_array[${H}]}"
  elif (( $M > 20 )); then
    time="Mid ${N_array[${H}]}'s"
  else
    time="New ${N_array[${H}]}"
  fi

fi

echo " | $time"
