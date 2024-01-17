local awful = require("awful")

local run_once = function(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", cmd, cmd))
  end
end


if ScreenCount > 1 then
  awful.spawn.with_shell("flatpak run org.telegram.desktop")

  run_once({
    "barrier",
    "nm-applet",
    "kmix",
    "blueman-applet",
    "xfce4-power-manager",
    "picom",
  })
end


