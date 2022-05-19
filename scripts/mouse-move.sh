#!/bin/bash
WHERE_TO=${1,,} # force lowercase
# WIN_ID=$(xdotool getactivewindow)


if [ $WHERE_TO == 'up' ]
then
  xdotool mousemove_relative 0 -33 sleep 0.4

elif [ $WHERE_TO == 'down' ]
then
  xdotool mousemove_relative 0 33 sleep 0.4

elif [ $WHERE_TO == 'left' ]
then
  xdotool mousemove_relative -- -33 0 sleep 0.4
  ## -- work around for negative numbers?? farks.

elif [ $WHERE_TO == 'right' ]
then
  xdotool mousemove_relative 33 0 sleep 0.4

elif [ $WHERE_TO == 'tl' ] # top left
then
  xdotool movemouse 0 0

elif [ $WHERE_TO == 'center' ]
then
  HERE=`xdotool getwindowfocus`

  ULX=`xwininfo -id $HERE | grep "  Absolute upper-left X:" | awk '{print $4}'`
  ULY=`xwininfo -id $HERE | grep "  Absolute upper-left Y:" | awk '{print $4}'`

  # If there is no window, ULX == 1 and ULY == 1.
  if [ $ULX != "-1" -o $ULY != "-1" ]; then
      eval `xdotool getwindowgeometry --shell $HERE`

      NX=`expr $WIDTH / 2`
      NY=`expr $HEIGHT / 2`
      NY=`expr $NY - $NY / 4`

      xdotool mousemove --window $WINDOW $NX $NY
  fi

elif [ $WHERE_TO == 'no-waterfox-update' ] # kill brave ad
then
  eval $(xdotool getmouselocation --shell)
  OX=$X
  OY=$Y

  wmctrl -a 'Waterfox'
  sleep 0.5 

  unset x y w h
  eval $(xwininfo -id $(xdotool getactivewindow) |
    sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
           -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
           -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
           -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )
  # notify-send "$x $y $w $h"

  NX=`expr $w - 50`
  NY=`expr $y + 50`

  sleep 0.5 
  xdotool mousemove $NX $NY
  sleep 0.5 
  xdotool click 1
  sleep 0.5 

  # xdotool mousemove $OX $OY

  notify-send "Did I Kill It??"


elif [ $WHERE_TO == 'bravead' ] # kill brave ad
then
  eval $(xdotool getmouselocation --shell)
  OX=$X
  OY=$Y

  wmctrl -a 'Brave'
  sleep 0.5 

  unset x y w h
  eval $(xwininfo -id $(xdotool getactivewindow) |
    sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
           -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
           -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
           -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )
  # notify-send "$x $y $w $h"

  NX=`expr $w - 50`
  NY=`expr $y + 50`

  sleep 0.5 
  xdotool mousemove $NX $NY
  sleep 0.5 
  xdotool click 3
  sleep 0.5 
  xdotool mousemove $OX $OY

  notify-send "Did I Kill It??"


else 
  xdotool movemouse 0 0

fi
