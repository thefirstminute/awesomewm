#!/bin/bash
QUITTIN_TIME = 10
if [ $(date '+%H') > $QUITTIN_TIME ] && [ $[ $RANDOM % 3 ] == 0 ] ; then
  # time="\e[31mEFF it O'Clock\e[31m"
  echo -e "\e[31mEFF it O'Clock\e[0m"
  exit 0

else
  declare -a N_array
  # N_array=(Oh Uno Too Trez For Fyv Six Sever Ate Noin X Elven 12 )
  N_array=(O I II III IV V VI VII VIII IX X XI XII )

  H=$(date '+%l')
  M=$(date '+%M')
  hour=${N_array[${H}]}

  if (( $M == 28 || $M == 29 || $M == 30 || $M == 31 )); then
    time="${N_array[${H}]} 30"
  elif (( $M > 44 )); then
    time="Old ${N_array[${H}]}"
  elif (( $M > 18 )); then
    time="Mid ${N_array[${H}]}"
  else
    time="New ${N_array[${H}]}"
  fi

fi

echo "$time"
