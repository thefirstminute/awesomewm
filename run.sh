#!/bin/bash

Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome


# Xephyr :1 -ac -screen 1024x768 &
# export DISPLAY=:1
#
# sleep 2
#
# awesome -c ~/.config/awesome/rc.lua
