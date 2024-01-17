local awful = require("awful")
local naughty = require("naughty")

awful.layout.layouts = {
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  awful.layout.suit.magnifier,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
  awful.layout.suit.floating,
}

-- Set layouts for specific tags and screens:
tag.connect_signal("property::layout", function(t)
  this_tag = t.name
  this_screen = t.screen.index

  if this_tag == "p" and this_screen == 1 then
    awful.layout.set(awful.layout.suit.tile.bottom, t)
  elseif this_tag == "[" and this_screen == 1 then
    awful.layout.set(awful.layout.suit.floating, t)
  end
end)
