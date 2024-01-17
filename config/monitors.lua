local naughty = require("naughty")
local awful = require("awful")

ScreenCount = screen.count()

LayoutMode = "laptop"
Monitor1 = ""
Monitor2 = ""
Monitor3 = ""

local xrandr_output = io.popen("xrandr"):read("*all")

-- Uncomment the following lines if you want to see xrandr output in notifications
-- naughty.notify({
--   title = "xrandr Output",
--   text = xrandr_output,
--   timeout = 0,
--   hover_timeout = 4.5,
-- })

if xrandr_output:find("LVDS%-1") then
  -- Stealth Bomber
  naughty.notify { text = "Stealth Detected", position = "bottom_left", }
  Monitor1 = "LVDS-1"
  if xrandr_output:find("VGA%-1") then
    naughty.notify { text = "VGA", position = "bottom_left" }
    Monitor2 = "VGA-1"
    Monitor3 = "VGA-1"
  end
  if xrandr_output:find("HDMI%-1") then
    LayoutMode = "desktop"
    naughty.notify { text = "HDMI", position = "bottom_left" }
    Monitor1 = "HDMI-1"
  end
elseif xrandr_output:find("eDP%-1") then
  -- Yoga Thinkpad
  naughty.notify { text = "Yoga Detected", position = "bottom_left" }
  Monitor1 = "eDP-1"
  Monitor2 = "eDP-1"
  Monitor3 = "eDP-1"
  if xrandr_output:find("DP%-1%-1") then
    naughty.notify { text = "DP-1", position = "bottom_left" }
    Monitor1 = "DP-1-1"
  end
  if xrandr_output:find("DP%-1%-2") then
    LayoutMode = "desktop"
    naughty.notify { text = "DP-2", position = "bottom_left" }
    Monitor2 = "DP-1-2"
  end
end



if ScreenCount == 2 then
  -- stealthy desktop mode
  awful.spawn.with_shell([[
  xrandr --output LVDS-1 --off --output VGA-1 --mode 1680x1050 --pos 1920x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal
  ]])
end
