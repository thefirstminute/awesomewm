#!/bin/bash
function run {
  if ! pgrep $1 ;
  then
    $1 &
  fi
}

#autorandr horizontal
isInFile=$( xrandr --prop | grep -c "DP-1-1")
if [ $isInFile -eq 0 ]; then
  # laptop:
  xrandr --output eDP-1 --primary --mode 1368x768 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off
else
  # desktop:
  xrandr --output eDP-1 --primary --mode 1368x768 --pos 1463x1080 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-1-1 --mode 1680x1050 --pos 0x30 --rotate normal --output DP-1-2 --mode 1920x1080 --pos 1680x0 --rotate normal --output DP-1-3 --off
fi


# run nm-applet
# run caffeine
# run blueberry-tray
# run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
# run volumeicon

# run xfce4-power-manager

# run conky -c $HOME/.config/awesome/system-overview



# run firefox
# run spotify
# run discord

# set wallpaper:
# feh --bg-fill $HOME/.config/awesome/wallpapers/0204.jpg
feh --bg-scale --no-xinerama $HOME/.config/awesome/wallpapers/default.jpg
# nitrogen --restore

numlockx on

# hide mouse cursor when I start typing
unclutter -keystroke
