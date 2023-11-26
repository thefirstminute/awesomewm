-- Includes:   ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local watch         = awful.widget.watch  -- For periodic command execution
-- Widget and layout library
local wibox         = require("wibox")
local widget        = wibox.widget
-- Theme handling library
local beautiful     = require("beautiful")
-- Notification library
local naughty       = require("naughty")

local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
                    -- require("awful.hotkeys_popup.keys")

-- menu
local menubar       = require("menubar")
local has_fdo, freedesktop = pcall(require, "freedesktop")
-- }}}

-- Error handling   ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "FAAAAAAAAK!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "The Bads Happen:",
      text = tostring(err) })
      in_error = false
    end)
  end
-- }}}

-- Variable definitions   ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{

-- Themes define colours, icons, font and wallpapers.
Wallpaper = "~/.config/awesome/default.jpg"
ThemeFont = "Hack Bold"
Cmain     = "#5d90cd"
Cdark     = "#191919"
Cdarkr    = "#111111"
Clite     = "#c2c2c2"
Cliter    = "#F9F1ED"
Cinfo     = "#8885b2"
Cerr      = "#ff2370"
Cwarn     = "#ff6523"
Cwin      = "#8aa234"

-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

local modkey = "Mod4" -- set in globalkeys.lua too!
-- local altkey = "Mod1" -- set in globalkeys.lua too!

-- local terminal = "kitty"
local terminal = "lxterminal"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

local browserProps = {switchtotag=false, floating=false, maximized=false}

MyTags={ "y", "u", "i", "o", "p", "[", "]", ";", "'" }

-- Table of layouts: {{{
awful.layout.layouts = {
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.floating,
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
  awful.layout.suit.floating,
}
-- }}}

-- Name monitors for spawns etc:
ScreenCount = screen.count()

LayoutMode = "laptop"
Monitor1=""
Monitor2=""
Monitor3=""

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
  naughty.notify { text = "Stealth Detected"}
  Monitor1="LVDS-1"
  if xrandr_output:find("VGA%-1") then
    naughty.notify { text = "VGA"}
    Monitor1="VGA-1"
    Monitor3="VGA-1"
  end
  if xrandr_output:find("HDMI%-1") then
    LayoutMode = "desktop"
    naughty.notify { text = "HDMI"}
    Monitor2="HDMI-1"
  end
elseif xrandr_output:find("eDP%-1") then
  -- Yoga Thinkpad
  naughty.notify { text = "Yoga Detected"}
  Monitor1="eDP-1"
  Monitor2="eDP-1"
  Monitor3="eDP-1"
  if xrandr_output:find("DP%-1%-1") then
    naughty.notify { text = "DP-1"}
    Monitor1="DP-1-1"
  end
  if xrandr_output:find("DP%-1%-2") then
    LayoutMode = "desktop"
    naughty.notify { text = "DP-2"}
    Monitor2="DP-1-2"
  end
end

-- Variable Definitions }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "refresh", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
                  menu_awesome,
                  menu_terminal,
                }
    })
end


local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Screen   ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- HEY: Do I Actually Need This??
-- {{{
-- local function set_wallpaper(s)
--   if beautiful.wallpaper then
--     local wallpaper = beautiful.wallpaper
--     -- If wallpaper is a function, call it with the screen
--     if type(wallpaper) == "function" then
--       wallpaper = wallpaper(s)
--     end
--     gears.wallpaper.maximized(wallpaper, s, true)
--   end
-- end
-- -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

-- -- No borders when rearranging only 1 non-floating or maximized client
-- BUG: this mofo wrecks my full screen:
-- screen.connect_signal("arrange", function (s)
--   local only_one = #s.tiled_clients == 1
--   for _, c in pairs(s.clients) do
--     if only_one then
--       c.border_width = 0
--     elseif c.maximized or c.fullscreen then
--       c.border_width = 0
--     else
--       c.border_width = beautiful.border_width
--     end
--   end
-- end)


-- TODO: TRY ME?
-- -- https://github.com/awesomeWM/awesome/issues/1607
-- client.connect_signal("property::fullscreen", function(c)
--   if c.fullscreen then
--     gears.timer.delayed_call(function()
--       if c.valid then
--         c:geometry(c.screen.geometry)
--       end
--     end)
--   end
-- end)


-- }}}

-- {{{ Wibar Stuff

-- Functions for creating taglist and tasklist:
-- {{{
local taglist_buttons = gears.table.join(
awful.button({ }, 1, function(t) t:view_only() end),
awful.button({ modkey }, 1, function(t)
  if client.focus then
    client.focus:move_to_tag(t)
  end
end),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, function(t)
  if client.focus then
    client.focus:toggle_tag(t)
  end
end),
awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)
local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
      "request::activate",
      "tasklist",
      {raise = true}
      )
    end
  end),
  awful.button({ }, 3, function ()
    awful.menu.client_list( { theme = { width = 250 } })
  end),
  awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
  awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)
-- }}}

-- Widgets:
-- {{{
--[[  NOTES: {{{
This Works straight in the wibar: awful.widget.watch('bash -c "free -h | awk \'/^Mem/ {print $3}\'"' ,5)

}}} --]]

-- SEPARATORS:   -----------------------------------------------------
-- {{{
-- local PIPE  = wibox.widget.textbox('|')
local SPACE = wibox.widget.textbox(' ')
-- }}}

-- MY FUZZY CLOCK:   -------------------------------------------------
-- {{{
local mytime = wibox.widget{
  font = "Hack Bold",
  widget = wibox.widget.textbox,
}
mytime = watch('bash -c "~/.config/awesome/scripts/klock.sh"', 333)
local time_widget = wibox.widget.background()
time_widget:set_widget(mytime)

-- modded from: https://pavelmakhov.com/2017/03/calendar-widget-for-awesome
local function cal_notify(cal_pref, pref_screen)
	if cal_notification == nil then
		awful.spawn.easy_async([[bash -c "]]..cal_pref..[[ | head -n -1 | sed 's/_.\(.\)/+\1-/g;s/  $//g;/2021$/d'"]],
		function(stdout, stderr, reason, exit_code)
			cal_notification = naughty.notify {
				text = string.gsub(string.gsub(stdout, "+", "<span background='#85492e'>"), "-", "</span>"),
				timeout = 0,
				margin = 20,
				screen = pref_screen,
				width = auto,
				destroy = function() cal_notification = nil end
			}
		end)
	else
		naughty.destroy(cal_notification)
	end
end

time_widget:connect_signal("button::release", function() cal_notify("cal 2021") end)
-- }}}

-- Resource Monitors:   ----------------------------------------------
-- {{{

-- local sys_mon = wibox.widget{
--   font = "Hack",
--   widget = wibox.widget.textbox,
-- }
-- sys_mon = watch('bash -c "~/.config/awesome/scripts/sys_mon.sh"', 5)
-- local sys_mon_widget = wibox.widget.background()
-- sys_mon_widget:set_widget(sys_mon)

local sys_cpu = wibox.widget{
  font = "Hack",
  widget = wibox.widget.textbox,
}
sys_cpu = watch('bash -c "~/.config/awesome/scripts/sys_cpu.sh"', 7)
local sys_cpu_widget = wibox.widget.background()
sys_cpu_widget:set_widget(sys_cpu)

local sys_mem = wibox.widget{
  font = "Hack",
  widget = wibox.widget.textbox,
}
sys_mem = watch('bash -c "~/.config/awesome/scripts/sys_mem.sh"', 17)
local sys_mem_widget = wibox.widget.background()
sys_mem_widget:set_widget(sys_mem)

-- local sys_hdd = wibox.widget{
--   font = "Hack",
--   widget = wibox.widget.textbox,
-- }
-- sys_hdd = watch('bash -c "~/.config/awesome/scripts/sys_hdd.sh"', 5000)
-- local sys_hdd_widget = wibox.widget.background()
-- sys_hdd_widget:set_widget(sys_hdd)

-- }}}

-- BATTERY:   --------------------------------------------------------
-- {{{
local batt_time = wibox.widget{
  font = "Hack",
  widget = wibox.widget.textbox,
}
batt_time = watch('bash -c "~/.config/awesome/scripts/battery-left.sh"', 33)
local batt_widget = wibox.widget.background()
batt_widget:set_widget(batt_time)
-- }}}

-- VOLUME    ---------------------------------------------------------
-- {{{
volumecfg = {}
volumecfg.cardid  = 0
volumecfg.channel = "Master"
volumecfg.widget = widget({ type = "textbox", name = "volumecfg.widget", align = "right" })

-- command must start with a space!
volumecfg.mixercommand = function (command)
       local fd = io.popen("amixer -c " .. volumecfg.cardid .. command)
       local status = fd:read("*all")
       fd:close()
       local volume = string.match(status, "(%d?%d?%d)%%")
       volume = string.format("% 3d", volume)
       status = string.match(status, "%[(o[^%]]*)%]")
       if string.find(status, "on", 1, true) then
               volume = volume .. "%"
       else
               volume = volume .. "M"
       end
       volumecfg.widget.text = volume
end
volumecfg.update = function ()
       volumecfg.mixercommand(" sget " .. volumecfg.channel)
end
volumecfg.up = function ()
       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " 5%+")
end
volumecfg.down = function ()
       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " 5%-")
end
volumecfg.toggle = function ()
       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " toggle")
end

volumecfg.widget:buttons(awful.util.table.join(
       awful.button({ }, 4, function () volumecfg.up() end),
       awful.button({ }, 5, function () volumecfg.down() end),
       awful.button({ }, 1, function () volumecfg.toggle() end)
))

-- volumecfg.update()
-- }}}

-- Create The Wibars:
-- {{{
awful.screen.connect_for_each_screen(function(s)
  -- {{{
  -- Each screen has its own tag table.
  awful.tag(MyTags, s, awful.layout.layouts[1])

  -- Create wibox
  s.mywibox  = awful.wibar({
    screen   = s,
    position = "top",
    height   = 22,
  })

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)

  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () mymainmenu:toggle() end),
    -- awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen    = s,
    filter    = awful.widget.taglist.filter.all,
    buttons   = taglist_buttons
  }
  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen     = s,
    filter     = awful.widget.tasklist.filter.currenttags,
    buttons    = tasklist_buttons
  }
  -- }}}

  -- Create different lefts and rights depending on monitor
  -- {{{
  if s.index == 1 then
    wiboxleft = { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      s.mytaglist,
      SPACE,
      s.mypromptbox,
      SPACE,
    }

    wiboxright = { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      -- Watch RAM
      -- awful.widget.watch('bash -c "free -h | awk \'/^Mem/ {print $3}\'"', 5),
      -- sys_mon_widget,
      sys_cpu_widget,
      sys_mem_widget,
      -- sys_hdd_widget,

      time_widget,
      batt_widget,
    }

  else
    wiboxleft = {
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      s.mytaglist,
      SPACE,
      s.mypromptbox,
      SPACE,
    }

    wiboxright = {
      layout = wibox.layout.fixed.horizontal,
    }

  end
  -- }}}

  -- Add widgets to the wibox
  -- {{{
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    wiboxleft,
    s.mytasklist,
    wiboxright,
  }
  -- }}}

end)
-- Create The Wibars }}}

-- Wibar }}}

-- END Wibar Stuff }}}

-- Mouse bindings   ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
root.buttons(gears.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))

clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)


-- }}}

-- Key bindings   ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
-- Set globalkeys
local globalkeys = require("globalkeys")
root.keys(globalkeys)

-- ClientKeys:   ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
local clientkeys = gears.table.join(
  awful.key({ modkey, }, "=",
  function (c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end,
  {description = "toggle fullscreen", group = "client"}),

  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
  {description = "close", group = "client"}),
  awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
  {description = "close", group = "client"}),
  awful.key({ modkey,           }, "BackSpace",      function (c) c:kill()                         end,
  {description = "close", group = "client"}),

  awful.key({ modkey, }, "f",  awful.client.floating.toggle                     ,
  {description = "toggle floating", group = "client"}),

  -- force tiling to work:
  awful.key({ modkey, "Shift" }, "f",
    function (c)
      c.maximized_horizontal = false
      c.maximized_vertical   = false
      c.maximized            = false
      c.floating             = false
    end),

  awful.key({ modkey, "Shift"   }, "Return", function (c) c:swap(awful.client.getmaster()) end,
  {description = "move to master", group = "client"}),

  awful.key({ modkey, "Shift"   }, ".",      function (c) c:move_to_screen()               end,
  {description = "move to screen", group = "client"}),

  awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end,
  {description = "toggle keep on top", group = "client"}),

  awful.key({ modkey, "Shift"   }, "-",
  function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end ,
  {description = "minimize", group = "client"}),

  awful.key({ modkey,           }, "-", function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
        "request::activate", "key.unminimize", {raise = true}
        )
      end
    end, {description = "restore minimized", group = "client"}),


  -- awful.key({ modkey, "Shift"   }, "v",
  -- function (c)
  --   c.maximized_vertical = not c.maximized_vertical
  --   c:raise()
  -- end ,
  -- {description = "(un)maximize vertically", group = "client"}),

  -- awful.key({ modkey, "Shift"   }, "m",
  -- function (c)
  --   c.maximized_horizontal = not c.maximized_horizontal
  --   c:raise()
  -- end ,
  -- {description = "(un)maximize horizontally", group = "client"}),

  awful.key({ modkey, "Control" }, "m",
  function (c)
    c.maximized = not c.maximized
    c:raise()
  end ,
  {description = "(un)maximize", group = "client"})
)

-- }}}
-- }}}

-- Rules    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {

  -- All clients will match this rule.
  { rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      size_hints_honor = false,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- titlebars
  { rule_any = {type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "com.liberty.jaxx",
      "Font-manager",
      "File-roller",
      "Gpick",
      "Imagewriter",
      "Kruler",
      "kruler",
      "Nemo",
      "MessageWin",  -- kalarm.
      "Peek",
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "veromix",
      "VirtualBox Manager",
      "Wpa_gui",
      "xtightvncviewer"
    },
    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester",  -- xev.
      "File Upload",  -- xev.
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "ConfigManager",  -- Thunderbird's about:config.
      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      "Popup",        -- e.g. waterfox upgrade dialog
      "Dialog",
    }
  }, properties = { floating = true }},

  -- Brave popup ## FIXME not working???
  -- make it eventually run a random countdown then close it automatically
  { rule = {
      name = "Awesome drawin" },
      properties = { floating = true, screen = Monitor3 },
      callback = function (c)
        awful.placement.bottom_right(c,nil)
      end },

  -- Floating clients but centered in screen
  { rule_any = {
    class = {
      "Arandr",
      "Galculator",
      "Gnome-calculator",
      "Gnome-calendar",
      "Polkit-gnome-authentication-agent-1",
      "Xfce4-terminal"
    },
    name = {
      "Site Manager",  -- filezilla
      "Synchronized browsing",  -- filezilla
    },
  },
  properties = { screen = Monitor3, floating = true },
  callback = function (c)
    awful.placement.centered(c,nil)
  end },


  -- rules for specific applications
  { rule = { class = "TelegramDesktop" },
      properties = { screen = Monitor1, tag = ";", switchtotag = false } },

  { rule = { class = "Skype" },
      properties = { screen = Monitor1, tag = "'", switchtotag = false } },

  -- Arduino editor:
  { rule = { class = "processing-app-Base" },
      properties = { screen = Monitor3, tag = "o", switchtotag = false } },

  { rule = { class = "VirtualBox Machine" },
      properties = { screen = Monitor2, tag = ";", switchtotag = false } },
  { rule = { class = "VirtualBox Manager" },
      properties = { screen = Monitor2, tag = "'", switchtotag = false } },

  -- keep rofi on laptop monitor:
  { rule = { class = "rofi" },
      properties = { screen = Monitor3, switchtotag = true } },


  -- browsers:
  -- {{{
  { rule = { class = "Chromium" },
      properties = { screen = Monitor1, tag = "y", switchtotag = true, floating = false, maximized = false } },

  { rule = { class = "Vivaldi-stable" },
      properties = { screen = Monitor1, tag = "p", switchtotag = true, floating = false, maximized = false} },


  -- firefox
  { rule = { class = "Firefox" },
      properties = { screen = Monitor1, tag = "i", switchtotag = true, floating = false, maximized = false },
      callback = function (c)
        awful.placement.centered(c,nil)
      end },
  -- firefox downloads:
  { rule = { class = "Firefox", name = "Library" },
      properties = { screen = Monitor3, floating = true },
      callback = function (c)
        awful.placement.centered(c,nil)
      end },
  -- firefox upload/file select:
  { rule = { class = "Firefox", name = "File Upload" },
      properties = { screen = Monitor3, floating = true, switchtotag = true },
      callback = function (c)
        awful.placement.centered(c,nil)
      end },

  { rule = { class = "waterfox-g3" },
      properties = { screen = Monitor1, tag = "[", switchtotag = false, maximized = false } }
  -- NOTE: keep ^this^ one last, with no comma at the end

  -- }}}



}
-- }}}

-- Signals   ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c) : setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton (c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton   (c),
      awful.titlebar.widget.ontopbutton    (c),
      awful.titlebar.widget.closebutton    (c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart applications
-- awful.spawn.with_shell("xfce4-power-manager")
awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh")

if ScreenCount>1 then
  awful.spawn.with_shell("flatpak run org.telegram.desktop")
end

-- vim:ft=lua:ts=2:sw=2:sts=2:tw=80:et
