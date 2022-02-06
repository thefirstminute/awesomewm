#!/bin/bash
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# run flatpaks
function run_fp {
  if ! pgrep $1 ;
  then
    flatpak run $2
  fi
}

#Check if we're docked
docked=$( xrandr --prop | grep -c "DP-1-1")
if [ $docked -eq 0 ]; then
  # laptop:
  xrandr --output eDP-1 --primary --mode 1368x768 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off
else
  # desktop:
  xrandr --output eDP-1 --primary --mode 1368x768 --pos 1450x1080 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-1-1 --mode 1680x1050 --pos 0x30 --rotate normal --output DP-1-2 --mode 1920x1080 --pos 1680x0 --rotate normal --output DP-1-3 --off

  # run skypeforlinux
  run_fp telegram org.telegram.desktop
fi

# run nm-applet
# run caffeine
# run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
# run volumeicon

# run xfce4-power-manager

# run conky -c $HOME/.config/awesome/system-overview

# set wallpaper:
# run nitrogen --restore
feh --bg-fill /media/jrk/therest/Pictures/dask/abs-3.jpeg


# run firefox
# run spotify
# run discord
