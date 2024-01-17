-- Require Stuff:
-- {{{
local client     = client
local awful      = require("awful")
local gears      = require("gears")
local menubar    = require("menubar")
local wibox      = require("wibox")
local watch      = awful.widget.watch -- For periodic command execution

-- my stuff
local menu       = require("config.menu")
local modkey     = require("config.vars").modkey
local terminal   = require("config.vars").terminal
local mytags     = require("config.tags")

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- SEPARATORS:   -----------------------------------------------------
-- {{{
local PIPE  = wibox.widget.textbox('|')
local SPACE = wibox.widget.textbox(' ')
-- }}}

-- Start Widgets:
-- {{{

-- }}}

-- Create a textclock widget
-- {{{
local mytime = wibox.widget {
  font = "Hack Bold",
  widget = wibox.widget.textbox,
}
mytime = watch('bash -c "~/.config/awesome/scripts/klock.sh"', 333)
local time_widget = wibox.widget.background()
time_widget:set_widget(mytime)
-- }}}


local taglist_buttons = gears.table.join(
-- {{{
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)-- }}}

local tasklist_buttons = gears.table.join(
-- {{{
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),

  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 350 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
end))-- }}}

awful.screen.connect_for_each_screen(function(s)
-- {{{
  -- Each screen has its own tag table.
  awful.tag(mytags, s, awful.layout.layouts[1])

  -- Layout box:
  -- {{{
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
  awful.button({}, 1, function() menu:toggle() end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 350 } })
  end),
  awful.button({}, 4, function() awful.layout.inc(1) end),
  awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- }}}

  -- Create a taglist widget
  -- {{{
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }
  -- }}}

  -- Create a tasklist widget
  -- {{{
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }
  -- }}}

  -- Create the wibox
  -- {{{
  s.mywibox = awful.wibar({
    screen = s,
    position = "top",
    height = 20,
  })
  -- }}}

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    {
      -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
    },
    -- Middle widget
    s.mytasklist,

    {
      -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      --if we're on the primary monitor, show the textclock
      s.mylayoutbox,
    },
  }
end)-- }}}
