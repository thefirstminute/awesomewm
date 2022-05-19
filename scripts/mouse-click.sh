#!/bin/bash

# TODO: make smarter for middle click, hold, and check if it's on etc... etc
# and just make an optional grab button
BTN=${1,,}

if [ $BTN == 'right']
then
  xdotool click 3
elif [ $BTN == 'up']
then
  xdotool click 4

elif [ $BTN == 'down']
then
  xdotool click 5

elif [ $BTN == 'middle']
then
  xdotool click 2

else
  xdotool click 1

fi
