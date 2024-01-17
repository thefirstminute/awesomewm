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

-- Widgets:
-- {{{

-- SEPARATORS:   -----------------------------------------------------
-- {{{
local PIPE  = wibox.widget.textbox(' | ')
local SPACE = wibox.widget.textbox(' ')
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

local sys_cpu = wibox.widget {
  font = "Hack",
  widget = wibox.widget.textbox,
}
sys_cpu = watch('bash -c "~/.config/awesome/scripts/sys_cpu.sh"', 7)
local sys_cpu_widget = wibox.widget.background()
sys_cpu_widget:set_widget(sys_cpu)

local sys_mem = wibox.widget {
  font = "Hack",
  widget = wibox.widget.textbox,
}
sys_mem = watch('bash -c "~/.config/awesome/scripts/sys_mem.sh"', 17)
local sys_mem_widget = wibox.widget.background()
sys_mem_widget:set_widget(sys_mem)


-- end Widgets }}}

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

  -- make monitor 1 get most of the stuff:
  local bar_right

  if s.index == 1 then
    bar_right = {
      layout = wibox.layout.fixed.horizontal,
      time_widget,
      PIPE,
      sys_cpu_widget,
      PIPE,
      sys_mem_widget,
      PIPE,
      wibox.widget.systray(),
    }

  end

  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.align.horizontal,
      s.mylayoutbox,
      SPACE,
      s.mytaglist,
      SPACE,
    },
    s.mytasklist,
    bar_right,
  }
end)-- }}}
