-- {{{
--[[
     Awesome WM configuration template
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop

     Copycats themes : https://github.com/lcpz/awesome-copycats

     lain : https://github.com/lcpz/lain

     TODO:
      VOLUME!?!!! WTF.
      - change wibar colour for active monitor

      - super r 'refresher' script
        pulls up rofi? ask to refresh vivaldi, firefox, chrome?
        (turn off run, I never use it)
      - super v refresh vivaldi

      - logout/restarts prompt first

      - check for monitors earlier, then change bindings based on 'mobile' or 'based'


      good looking ideas/functions here:?
      https://github.com/folknor/awesomewm-config/blob/master/rc.lua
      https://github.com/ImmanuelHaffner/awesomewm/blob/master/rc.lua

      this guy seems to have a modular setup that works:
      https://github.com/madprops/awesome-setup

--]]
-- }}}


-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")
local menubar       = require("menubar")
-- Widget and layout library
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")

local lain          = require("lain")
local freedesktop   = require("freedesktop")

local hotkeys_popup = require("awful.hotkeys_popup").widget
                      -- Show keys for client with a matching name:
                      -- require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100


local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
-- }}}


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


--[[ {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
run_once({ "unclutter -root", "telegram-cli" }) -- entries must be comma-separated
-- }}} --]]


-- {{{ Variable definitions

-- local themes = {
--   "blackburn",       -- 1 : tag symbols...lots of meh
--   "copland",         -- 2 : only shows tags that have stuff, box widget/gauges
--   "dremora",         -- 3 : good starter
--   "holo",            -- 4 : Like layout img, nice media player, bottom bar
--   "test",            -- 5
--   "multicolor",      -- 6 : like icons for widgets
--   "powerarrow",      -- 7 : just works. battery widget is nice. meh
--   "powerarrow-blue", -- 8 : ^ but ugly nice mountain background
--   "powerarrow-dark", -- 9 : glitchy
--   "rainbow",         -- 10 : meh
--   "steamburn",       -- 11 : good starter. like text layout idea
--   "vertex"           -- 12 : cool, but glitchy with multi-monitor
-- }
-- local chosen_theme = themes[2]

-- modkey or mod4 = super key
local modkey       = "Mod4"
local altkey       = "Mod1"

-- personal variables
--change these variables if you want
local browser1          = "chromium"
local browser2          = "firefox"
local browser3          = "vivaldi-stable"
local editorgui         = "geany"
local filemanager       = "thunar"
local mediaplayer       = "spotify"

local terminal   = "kitty"
local terminal_cmd = terminal .. " -e "

Confirm = "echo -e 'No\nYes' | dmenu -p Really?"

local myprompt = awful.widget.prompt {
    prompt = 'Execute: '
}
myprompt:run()

-- Name monitors for spawns etc:
if screen.count() > 1 then
  Monitor1="DP-1-1"
  Monitor2="DP-1-2"
  Monitor3="eDP-1"
  -- naughty.notify { text = "Monitor Count: "..screen.count().." Monitor1: ".. Monitor1 }
else
  Monitor1="eDP-1"
  Monitor2="eDP-1"
  Monitor3="eDP-1"
  -- naughty.notify { text = "Monitor Count: "..screen.count().." Monitor1: ".. Monitor1 }
end


-- awesome variables
awful.util.terminal = terminal
-- awful.util.tagnames = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒", "➓" }
awful.util.tagnames = { "y", "u", "i", "o", "p", "[", "]", ";", "'" }
--awful.util.tagnames = {  " ", " ", " ", " ", " ", " ", " ", " ", " ", " "  }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }

-- awful.layout.suit.tile.left.mirror = true
-- what does this do?? ^^^
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    -- lain.layout.cascade,
    -- lain.layout.cascade.tile,
    lain.layout.centerwork,
    -- lain.layout.centerwork.horizontal,
    -- lain.layout.termfair,
    -- lain.layout.termfair.center,
    awful.layout.suit.floating,
}

awful.util.taglist_buttons = my_table.join(
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

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = dpi(250)}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

-- lain.layout.termfair.nmaster           = 3
-- lain.layout.termfair.ncol              = 1
-- lain.layout.termfair.center.nmaster    = 3
-- lain.layout.termfair.center.ncol       = 1
-- lain.layout.cascade.tile.offset_x      = dpi(2)
-- lain.layout.cascade.tile.offset_y      = dpi(32)
-- lain.layout.cascade.tile.extra_padding = dpi(5)
-- lain.layout.cascade.tile.nmaster       = 5
-- lain.layout.cascade.tile.ncol          = 2

-- beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- beautiful.init("~/.config/awesome/themes/copland/theme.lua")
-- beautiful.init("~/.config/awesome/themes/powerarrow/theme.lua")
beautiful.init("~/.config/awesome/theme.lua")

-- }}}


-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "reload awesome", function() return false, awesome.restart end },
    { "arandr", "arandr" },
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "Terminal", terminal },
        { "Awesome", myawesomemenu },
        { "ViFm", "vifm" },
    },
    after = {
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" },
    }
})
-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}


-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 2
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s)
    -- s.systray = wibox.widget.systray()
    -- s.systray.visible = false
 end)

-- }}}


-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}


-- {{{ Key bindings
globalkeys = my_table.join(

--{{{ probations:
    awful.key({ modkey, "Shift"   }, "7",      function (c) c:move_to_screen()               end,
              {description = "move to staples", group = "screen"}),
    awful.key({ modkey }, ",", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey, altkey, "Control" }, "q", function () awful.util.spawn( terminal_cmd.."systemctl poweroff" ) end,
              {description = "Power Off" , group = "System" }),

--}}}

    -- {{{ Super+

    -- TAG-BASED KEYBINDING From: https://github.com/folknor/awesomewm-config/blob/master/rc.lua
    awful.key({ modkey }, "b", function()
        local t = awful.screen.focused().selected_tag
        if t.index == 1 then awful.util.spawn("chromium")
        elseif t.index == 3 then awful.util.spawn("vivaldi-stable")
        elseif t.index == 4 then awful.util.spawn("firefox")
        else awful.util.spawn("LibreWolf") end
    end, {description = "open default tag program", group = "tag"}),


    awful.key({ modkey,  }, "Return", function () awful.spawn( terminal ) end,
              {description = terminal, group = "launch"}),

    awful.key({ modkey, }, "/",      hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),

    awful.key({ modkey, }, "a", function () awful.util.mymainmenu:show() end,
        {description = "show main menu", group = "awesome"}),

    awful.key({ modkey, }, "c", function () awful.util.spawn( "conky-toggle" ) end,
        {description = "conky-toggle", group = "super"}),

    awful.key({ modkey, }, "m", function () awful.util.spawn( "xdotool mousemove 0 0"  ) end,
        {description = "move mouse to top corner", group = "super"}),

    awful.key({ modkey, }, "r", function() awful.screen.focused().mypromptbox:run() end,
      {description = "run prompt", group = "launch"}),

    awful.key({ modkey, }, "s", function () awful.util.spawn( "rofi -show drun" ) end,
      {description = "rofi" , group = "launch" }),

    awful.key({ modkey, }, "t", function () awful.util.spawn( "flatpak run org.telegram.desktop" ) end,
      {description = "telegram" , group = "launch" }),

    awful.key({ modkey, }, "w", function () awful.util.spawn( "rofi -show window" ) end,
      {description = "rofi" , group = "launch" }),





    -- Volume Widget Controls {{{
    awful.key({ modkey }, "=", function() volume_widget:inc() end),
    awful.key({ modkey }, "-", function() volume_widget:dec() end),
    awful.key({ modkey }, "0", function() volume_widget:toggle() end),
    -- }}}

    -- awful.key({ modkey, "Control", "Shift" }, "k", function () awful.util.spawn("~/.bin/layout-ir.sh") end),


    -- awful.key({ modkey, }, "g", function () awful.screen.focused().quake:toggle() end,
    --           {description = "Guake", group = "launch"}),


    -- {{{ Tag & Window Jumping
    -- awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
    --     {description = "view previous", group = "tag"}),
    -- awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        -- {description = "view next", group = "tag"}),


    -- awful.key({ modkey,           }, "Tab",   awful.tag.viewnext,
    --     {description = "view next", group = "tag"}),
    -- awful.key({ modkey, "Shift"   }, "Tab",  awful.tag.viewprev,
    --     {description = "view previous", group = "tag"}),

    -- client focus by direction
    -- {{{
    -- [[
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),
    --]]
    -- }}}

    -- focus lapttop style:
    -- {{{
    --[[
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ modkey,           }, "l",   awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "h",  awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    --]]
    -- }}}

    -- Screen Focus
    awful.key({ modkey }, ".", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey }, ",", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    -- Quick Launch
    -- awful.key({ modkey         }, "b", function () awful.spawn( browser1 ) end,
    --           {description = browser1, group = "launch"}),

    -- }}}

    -- Super+ }}}

    -- {{{ Super+Alt+ (mostly launching stuff)

    awful.key({ modkey, altkey }, "b", function () awful.util.spawn( browser1 ) end,
        {description = browser1, group = "launch" }),
    awful.key({ modkey, altkey }, "w", function () awful.util.spawn( browser2 ) end,
        {description = browser2, group = "launch" }),
    awful.key({ modkey, altkey }, "o", function () awful.util.spawn( browser3 ) end,
        {description = browser3, group = "launch" }),
    awful.key({ modkey, altkey }, "s", function () awful.util.spawn( "surf www.duckduckgo.com" ) end,
        {description = "surf web browser" , group = "launch" }),



    -- awful.key({ modkey, altkey }, "c", function () awful.util.spawn( terminal.." -e cmus" ) end,
    --     {description = "cmus" , group = "terminal apps" }),
    -- awful.key({ modkey, altkey }, "y", function () awful.util.spawn( terminal.." -e youtube-viewer" ) end,
    --     {description = "youtube-viewer" , group = "terminal apps" }),



    -- awful.key({ modkey, altkey }, "Return", function () awful.spawn( terminal.." -e fish" ) end,
    --           {description = "terminal with fish shell", group = "super"}),

    -- awful.key({ modkey, altkey }, "q", function () awful.screen.focused().quake:toggle() end,
    --           {description = "dropdown application", group = "super"}),

    -- awful.key({ modkey, altkey }, "c", function () lain.widget.calendar.show(7) end,
    --           {description = "show calendar", group = "widgets"}),
    -- awful.key({ modkey, altkey }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
    --           {description = "show filesystem", group = "widgets"}),
    -- awful.key({ modkey, altkey }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
    --           {description = "show weather", group = "widgets"}),

    -- Super+Alt+ }}}

    -- {{{ Super+Control+

    -- Non-empty tag browsing
    awful.key({ modkey, "Control" }, "h", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ modkey, "Control"}, "l", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),

    -- Super+Control+ }}}

    -- {{{ Super+Shift+ (mostly moving stuff)
    -- Layout manipulation
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)     end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)     end,
              {description = "select previous", group = "layout"}),

    -- awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
    --           {description = "swap with next client by index", group = "client"}),
    -- awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
    --           {description = "swap with previous client by index", group = "client"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "Prior", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Next", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Delete", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),

    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}),

    -- Resizeing Windows:
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),


    awful.key({ modkey, "Shift"   }, "+",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "_",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    -- awful.key({ modkey, "Shift" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Shift" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),


    -- Super+Shift+ }}}

    -- {{{ Alt+Control+ (mostly system controls)

    --I usually use this for system commands...
    awful.key({ altkey, "Control" }, "Return", function () awful.util.spawn( "xfce4-terminal --drop-down" ) end,
      {description = "dropdown terminal" , group = "specialkeys"}),

    -- this isn't working...
    awful.key({ altkey, "Control" }, "t", function () awful.spawn.with_shell( "~/.config/mybin/touchscreen.sh"  ) end,
        {description = "touchscreen matrix", group = "System"}),


    awful.key({ altkey, "Control" }, "w", function () awful.spawn.with_shell( "feh --randomize --bg-scale --no-xinerama ~/.config/awesome/wallpapers/*"  ) end,
        {description = "wallpaper", group = "System"}),

    -- Awesome:
    awful.key({ altkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),

    -- awful.key({ altkey, "Control" }, "s",  function ()
    --       if awful.util.pread(Confirm):sub(1, 3) == "Yes" then
    --         awful.spawn.with_shell( 'systemctl suspend' )
    --       end
    --     end,
    --     {description = "sleep", group = "System"}),

    awful.key({ altkey, "Control"   }, "s",  function () awful.spawn.with_shell( '~/.dmenu/prompt "are you sure?" "systemctl suspend"' ) end,
              {description = "Suspend", group = "System"}),

    awful.key({ altkey, "Control" }, "l",  function () awesome.quit() end,
              {description = "quit awesome", group = "System"}),

    -- Show/Hide Wibox
    awful.key({ altkey, "Control" }, "f", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- Change gaps
    awful.key({ altkey, "Control" }, "[", function () lain.util.useless_gaps_resize(1) end,
      {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "]", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

    awful.key({ altkey, "Control" }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({ altkey, "Control" }, "Right", function() awful.spawn.with_shell("$HOME/.config/mybin/bright-up-inc") end,
        {description = "Brightness Up", group = "alt+ctrl"}),
    awful.key({ altkey, "Control" }, "Left", function() awful.spawn.with_shell("$HOME/.config/mybin/bright-down-inc") end,
        {description = "Brightness Down", group = "alt+ctrl"}),

    awful.key({ altkey, "Control" }, "Up", function () awful.util.spawn("amixer -D pulse sset Master 5%+", false) end),
    awful.key({ altkey, "Control" }, "Down", function () awful.util.spawn("amixer -D pulse sset Master 10%-", false) end),
    awful.key({ altkey, "Control" }, "v", function () awful.util.spawn("amixer -D pulse sset Master toggle", false) end),

    -- Copy primary to clipboard (terminals to gtk)
    -- awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
    --           {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    -- awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
    --           {description = "copy gtk to terminal", group = "hotkeys"}),

    -- Alt+Control+ }}}

    -- {{{ Control+
    awful.key({ "Control"         }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    -- }}}

    -- {{{ Laptop & Special Buttons:

    awful.key({ }, "Print", function () awful.util.spawn( "xfce4-screenshooter" ) end,
        {description = "Xfce screenshot", group = "specialkeys"}),

    -- awful.key({ }, "F2", function() menubar.show() end,
    --           {description = "show the menubar", group = "specialkeys"}),
    awful.key({ "Shift" }, "F4", function () awful.util.spawn( browser1 ) end,
      {description = browser1, group = "specialkeys"}),
    awful.key({ "Shift" }, "F10", function () awful.util.spawn( "rofi -show drun -fullscreen" ) end,
      {description = "rofi fullscreen" , group = "function keys" }),
    awful.key({ "Shift", }, "F11", function () awful.util.spawn( "rofi -show drun" ) end,
      {description = "rofi" , group = "function keys" }),
    awful.key({ "Shift", }, "F12", function () awful.util.spawn( "Xfce4-terminal --drop-down" ) end,
      {description = "dropdown terminal" , group = "specialkeys"}),


    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function() awful.spawn.with_shell("$HOME/.config/mybin/bright-up-inc") end),
              -- {description = "+10%", group = "specialkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function() awful.spawn.with_shell("$HOME/.config/mybin/bright-down-inc") end),
              -- {description = "-10%", group = "specialkeys"}),



    -- Volume Control {{{

    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -D pulse sset Master 5%+", false) end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -D pulse sset Master 10%-", false) end),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer -D pulse sset Master toggle", false) end),


    -- END Volume }}}

    --  END Laptop & Special Buttons }}}

    -- {{{ Alt+
    awful.key({ altkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),

    -- Default client focus
    awful.key({ altkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey, "Shift"   }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),


    -- -- Default client focus
    -- awful.key({ altkey,           }, "j",
    --     function ()
    --         awful.client.focus.byidx( 1)
    --     end,
    --     {description = "focus next by index", group = "client"}
    -- ),
    -- awful.key({ altkey,           }, "k",
    --     function ()
    --         awful.client.focus.byidx(-1)
    --     end,
    --     {description = "focus previous by index", group = "client"}
    -- ),

    -- Alt+ }}}

    -- {{{ Alt+Shift+
    -- Run Lua
    awful.key({ altkey, "Shift" }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    -- Alt+Shift }}}


    -- Random Tests... {{{

    awful.key({ altkey, "Control" }, "m",
        function ()
            naughty.notify { text = "Monitor Count: "..screen.count().." Monitor1: ".. Monitor1 }
        end
        ),

    awful.key({ modkey, "Control" }, ",", function ()
                awful.menu({ items = { { "Cancel", function() do end end },
                { "Quit", function() awesome.quit() end } }
              })

            end,
            {description = "FAAAARKS!", group = "awesome"}),

    -- My debugger message to show random info
    -- keep this last because no ","!!!

    awful.key({ altkey, "Control" }, ".",
        function ()

        awful.client.incwfact(-0.05)

          --     text = awful.spawn.with_shell ("~/.config/mybin/fuzzy-clock.sh", 60),
            -- naughty.notify { text = "Time: "..awful.spawn.easy_async(terminal.." -e ./.config/mybin/fuzzy-clock.sh") }
            -- naughty.notify { text = "Time: "..awful.util.spawn(" ./.config/mybin/fuzzy-clock.sh") }
            -- naughty.notify { text = "Time: "..awful.spawn.with_line_callback(terminal.." ./.config/mybin/fuzzy-clock.sh") }
            -- naughty.notify { text = "Time: "..awful.util.spawn("~/.config/mybin/fuzzy-clock.sh") }
            -- naughty.notify { text = "Time: "..awful.spawn("~/.config/mybin/fuzzy-clock.sh") }
            -- naughty.notify { text = "Time: "..awful.util.spawn("~/.config/mybin/fuzzy-clock.sh") }
            -- naughty.notify { text = "Time: "..awful.spawn.with_shell ("$HOME/.config/mybin/fuzzy-clock.sh") }
        end
        )

    -- END Random Tests }}}

) -- END of globalkeys

-- }}}


-- {{{ Tag Jumping
local mytag={ "y", "u", "i", "o", "p", "[", "]", ";", "'" }
for i = 1, 9 do

    -- Hack to only show tags 1 and 9 in the shortcut window
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end

    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, mytag[i],
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, mytag[i],
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, mytag[i],
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, mytag[i],
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end
-- END Tag jumping }}}

-- Actually Set Keys:
root.keys(globalkeys)

-- {{{

clientkeys = my_table.join(

    awful.key({ modkey            }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
              -- ^^ just keeping this standard ^^
    -- awful.key({ modkey, "Shift"   }, "f",  awful.client.floating.toggle                     ,
    --           {description = "toggle floating", group = "client"}),
              -- ^^ this freezes the whole system up???
    awful.key({ modkey, "Shift"   }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),

    awful.key({ modkey, "Shift"   }, ",",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),

    awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),

    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "-",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Shift"   }, "v",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),

    awful.key({ modkey, "Shift"   }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
              c:emit_signal(
                  "request::activate", "key.unminimize", {raise = true}
              )
            end
        end,
        {description = "restore minimized", group = "client"}),

    awful.key({ modkey, "Shift"   }, "/",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
) -- END CLIENTKEYS

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


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
-- find class or role via xprop command
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },
    -- { rule = { class = "Thunar" },
    --     properties = { maximized = false, floating = false } },

    -- Set applications to always map on specific tags/screens:
    { rule = { class = "Chromium" },
        properties = { screen = Monitor1, tag = "y", switchtotag = true, floating = false } },

    {rule = {class = "Firefox"},
        properties = { screen = Monitor1, tag = "p", switchtotag = true, floating = false }},

    { rule = { class = "Vivaldi-stable" },
        properties = { screen = Monitor1, tag = "i", switchtotag = true, floating = false } },

    {rule = {class = "Filezilla"},
        properties = { screen = Monitor3, tag = "o", switchtotag = true                   }},

    { rule = { class = "TelegramDesktop" },
        properties = { screen = Monitor1, tag = "'", switchtotag = true, floating = false } },

    -- Set applications to be maximized at startup.
    -- { rule = { class = editorgui },
    --       properties = { maximized = true } },

    { rule = { class = "Geany" },
        properties = { maximized = false, floating = false } },

    { rule = { class = "Gimp*", role = "gimp-image-window" },
        properties = { maximized = true } },

    { rule = { class = "inkscape" },
        properties = { maximized = true } },

    { rule = { class = mediaplayer },
        properties = { maximized = true } },

    { rule = { class = "Vlc" },
        properties = { maximized = true } },

    { rule = { class = "VirtualBox Manager" },
        properties = { screen = Monitor3, tag = "]", switchtotag = true, floating = false, maximized = true } },
    { rule = { class = "VirtualBox Machine" },
        properties = { screen = Monitor2, tag = "[", switchtotag = true, floating = false, maximized = true } },

    { rule = { class = "Xfce4-settings-manager" },
          properties = { floating = false } },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          -- "Arandr",
          "Blueberry",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Peek",
          "System-config-printer.py",
          "Sxiv",
          "Unetbootin.elf",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"
        },
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},

    -- Floating clients but centered in screen
    { rule_any = {
       	class = {
          "Arandr",
          "Galculator",
          "Gnome-calculator",
          "Gnome-calendar",
          "Nemo",
          "kruler",
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
       		end }
}
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = dpi(18)}) : setup {
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
awful.spawn.with_shell("~/.config/awesome/autostart.sh")

-- awful.spawn.with_shell("nitrogen --restore")
-- awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")

    -- FAILS: {{{
    -- awful.key({  }, "XF86AudioRaiseVolume",
    --     function ()
    --         os.execute(string.format("pamixer -i 10 --allow-boost", beautiful.volume.channel))
    --         beautiful.volume.update() end, {description = "volume up", group = "hotkeys"}),
    -- awful.key({ }, "XF86AudioLowerVolume",
    --     function ()
    --         os.execute(string.format("pamixer -d 10 --allow-boost", beautiful.volume.channel))
    --         beautiful.volume.update() end, {description = "volume down", group = "hotkeys"}),
    -- awful.key({ }, "XF86AudioMute",
    --     function ()
    --         os.execute(string.format("pamixer --toggle-mute", beautiful.volume.togglechannel or beautiful.volume.channel))
    --         beautiful.volume.update() end, {description = "toggle mute", group = "hotkeys"}),


    -- ALSA volume control
    -- awful.key({ }, "XF86AudioRaiseVolume",
    --     function ()
    --         os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
    --         beautiful.volume.update()
    --     end),
    -- awful.key({ }, "XF86AudioLowerVolume",
    --     function ()
    --         os.execute(string.format("amixer -q set %s 10%%-", beautiful.volume.channel))
    --         beautiful.volume.update()
    --     end),
    -- awful.key({ }, "XF86AudioMute",
    --     function ()
    --         os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
    --         beautiful.volume.update()
    --     end),

    -- awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end),
              -- {description = "+10%", group = "specialkeys"}),
    -- awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end),
              -- {description = "-10%", group = "specialkeys"}),
    -- }}}
