local gears         = require("gears")
local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local modkey = "Mod4"
local altkey = "Mod1"

local terminal = "kitty"
-- local editor = os.getenv("EDITOR") or "nvim"
-- local editor_cmd = terminal .. " -e " .. editor

local globalkeys = gears.table.join(

  -- {{{ Mod+
  -- Layout manipulation
  awful.key({ modkey,           }, "\\", function () awful.layout.inc( 1)     end,
            {description = "select next", group = "layout"}),
  -- awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)     end,
  --           {description = "select previous", group = "layout"}),

  -- Getting Around
  -- {{{

  -- got to previous tag
  awful.key({ modkey,           }, "Tab", awful.tag.history.restore,
    {description = "go back", group = "tag"}),

  awful.key({ modkey, }, "Left",   awful.tag.viewprev,
      {description = "view previous", group = "tag"}),
  awful.key({ modkey, }, "Right",  awful.tag.viewnext,
      {description = "view next", group = "tag"}),


  -- Screen Focus
  awful.key({ modkey }, ".", function () awful.screen.focus_relative( 1) end,
            {description = "focus the next screen", group = "screen"}),
  awful.key({ modkey }, ",", function () awful.screen.focus_relative(-1) end,
            {description = "focus the previous screen", group = "screen"}),


  -- Getting Around }}}


  -- Launching Stuff:
  --{{{
  -- TAG-BASED KEYBINDING From: https://github.com/folknor/awesomewm-config/blob/master/rc.lua

  awful.key({ modkey,  }, "Return", function () awful.spawn( terminal ) end,
    {description = terminal, group = "launch"}),

  awful.key({ modkey, }, "/",      hotkeys_popup.show_help,
    {description = "show help", group="awesome"}),

  awful.key({ modkey, }, "c", function () awful.util.spawn( "conky-toggle" ) end,
    {description = "conky-toggle", group = "super"}),

  awful.key({ modkey, }, "m", function () awful.util.spawn( "xdotool mousemove 0 0"  ) end,
    {description = "move mouse to top corner", group = "super"}),

  awful.key({ modkey, }, "r", function() awful.screen.focused().mypromptbox:run() end,
    {description = "run prompt", group = "launch"}),

  awful.key({ modkey, }, "s", function () awful.util.spawn( "rofi -show drun" ) end,
    {description = "rofi" , group = "launch" }),

  awful.key({ modkey, }, "Space", function () awful.util.spawn( "rofi -show drun" ) end,
    {description = "rofi" , group = "launch" }),


  awful.key({ modkey, }, "w", function () awful.util.spawn( "rofi -show window" ) end,
    {description = "rofi" , group = "launch" }),

  -- Launching Stuff }}}

  -- Mod }}}

  -- {{{ Alt+
  awful.key({ altkey }, "u", awful.client.urgent.jumpto,
            {description = "jump to urgent client", group = "client"}),

  -- TODO: Make this work across monitors?!?
  awful.key({ altkey }, ".", function () awful.client.focus.byidx( 1) end,
      {description = "focus next", group = "client"}),
  awful.key({ altkey,           }, ",", function () awful.client.focus.byidx(-1) end,
      {description = "focus back", group = "client"}),

  awful.key({ altkey            }, "Tab",
      function ()
          awful.client.focus.history.previous()
          if client.focus then
              client.focus:raise()
          end
      end,
      {description = "focus previous", group = "client"}),

  -- Alt }}}

  -- {{{ Control+
  -- }}}

  -- {{{ Mod+Alt+ (mostly launching stuff)

  awful.key({ modkey, altkey }, "s", function () awful.util.spawn( "brave-browser www.duckduckgo.com" ) end,
    {description = "brave browser search ddg" , group = "launch" }),

  -- awful.key({ modkey, altkey }, "Return", function () awful.spawn( terminal.." -e fish" ) end,
  --   {description = "terminal with fish shell", group = "launch"}),

  awful.key({ modkey, altkey }, "t", function () awful.util.spawn( "flatpak run org.telegram.desktop" ) end,
    {description = "telegram" , group = "launch" }),

  awful.key({ modkey, altkey }, "b", function()
      local t = awful.screen.focused().selected_tag
      if t.index == 1 then awful.util.spawn("chromium")
      elseif t.index == 3 then awful.util.spawn("vivaldi-stable")
      elseif t.index == 4 then awful.util.spawn("firefox")
      else awful.util.spawn("LibreWolf") end
  end, {description = "open default tag program", group = "tag"}),

  -- Super+Alt+ }}}

  -- {{{ Alt+Control+ (mostly system controls)

  --I usually use this terminal for system commands...
  awful.key({ altkey, "Control" }, "Return", function () awful.util.spawn( "xfce4-terminal --drop-down" ) end,
    {description = "dropdown terminal" , group = "specialkeys"}),

  awful.key({ altkey, "Control" }, "w", function () awful.spawn.with_shell( "feh --randomize --bg-scale --no-xinerama ~/.config/awesome/wallpapers/*"  ) end,
    {description = "wallpaper", group = "System"}),

  awful.key({ altkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "System"}),

  awful.key({ altkey, "Control" }, "s",  function () awful.spawn.with_shell( 'echo "are you sure?" | rofi -dmenu "systemctl suspend"' ) end,
    {description = "Suspend", group = "System"}),

  -- awful.key({ altkey, "Control" }, "s",  function ()
  --       if awful.util.pread(Confirm):sub(1, 3) == "Yes" then
  --         awful.spawn.with_shell( 'systemctl suspend' )
  --       end
  --     end,
  --     {description = "sleep", group = "System"}),

  awful.key({ altkey, "Control" }, "l",  function () awesome.quit() end,
    {description = "quit awesome", group = "System"}),

  -- Show/Hide Wibox
  awful.key({ altkey, "Control" }, "b", function ()
    for s in screen do
      s.mywibox.visible = not s.mywibox.visible
      if s.mybottomwibox then
        s.mybottomwibox.visible = not s.mybottomwibox.visible
      end
    end
  end,
  {description = "toggle wibox", group = "System"}),

  -- Change gaps
  awful.key({ altkey, "Control" }, "[", function () lain.util.useless_gaps_resize(1) end,
    {description = "increment useless gaps", group = "System"}),
  awful.key({ altkey, "Control" }, "]", function () lain.util.useless_gaps_resize(-1) end,
    {description = "decrement useless gaps", group = "System"}),


  -- Brightness {{{
  awful.key({ altkey, "Control" }, "Right", function() awful.spawn.with_shell("~/.config/awesome/scripts/bright-up") end,
      {description = "Brightness Up", group = "alt+ctrl"}),
  awful.key({ altkey, "Control" }, "Left", function() awful.spawn.with_shell("~/.config/awesome/scripts/bright-down") end,
      {description = "Brightness Down", group = "alt+ctrl"}),
  -- awful.key({ altkey, "Control" }, "Right", function () awful.util.spawn("xbacklight -inc 10") end,
  --     {description = "Brightness Up", group = "System"}),
  -- awful.key({ altkey, "Control" }, "Left", function () awful.util.spawn("xbacklight -dec 10") end,
  --     {description = "Brightness Down", group = "System"}),

  --}}}


  -- Volume Controls {{{
  -- pactl seemed to go louder...
  awful.key({ altkey, "Control" }, "Up", function () awful.util.spawn("amixer -D pulse sset Master 5%+", false) end,
      {description = "Volume Up", group = "System"}),
  awful.key({ altkey, "Control" }, "Down", function () awful.util.spawn("amixer -D pulse sset Master 10%-", false) end,
      {description = "Volume Down", group = "System"}),
  awful.key({ altkey, "Control" }, "v", function () awful.util.spawn("amixer -D pulse sset Master toggle", false) end,
      {description = "Volume Toggle", group = "System"}),

  awful.key({ modkey, "Control" }, "Up", function () awful.util.spawn("pactl -- set-sink-volume 0 +5%", false) end,
      {description = "Volume Up", group = "System"}),
  awful.key({ modkey, "Control" }, "Down", function () awful.util.spawn("pactl -- set-sink-volume 0 -5%", false) end,
      {description = "Volume Down", group = "System"}),



    -- }}}


  -- Alt+Control+ }}}

  -- {{{ Mod+Shift+ (mostly moving stuff)

  -- -- Dynamic tagging (Need Lain)
  -- awful.key({ modkey, "Shift" }, "Prior", function () lain.util.add_tag() end,
  --           {description = "add new tag", group = "tag"}),
  -- awful.key({ modkey, "Shift" }, "Next", function () lain.util.delete_tag() end,
  --           {description = "delete tag", group = "tag"}),
  -- awful.key({ modkey, "Shift" }, "Delete", function () lain.util.rename_tag() end,
  --           {description = "rename tag", group = "tag"}),

  -- Resizeing Windows:
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    {description = "increase master width factor", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    {description = "decrease master width factor", group = "layout"}),


  awful.key({ modkey, "Shift"   }, "+",     function () awful.tag.incnmaster( 1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "_",     function () awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),

  -- Mod+Shift }}}

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

  -- {{{ Laptop & Special Buttons:

  awful.key({ }, "Print", function () awful.util.spawn( "xfce4-screenshooter" ) end,
      {description = "Xfce screenshot", group = "specialkeys"}),

  awful.key({ }, "F2", function() menubar.show() end,
    {description = "show the menubar", group = "specialkeys"}),

  -- awful.key({ "Shift" }, "F4", function () awful.util.spawn( browser1 ) end,
  --   {description = browser1, group = "specialkeys"}),
  -- awful.key({ "Shift" }, "F10", function () awful.util.spawn( "rofi -show drun -fullscreen" ) end,
  --   {description = "rofi fullscreen" , group = "function keys" }),
  -- awful.key({ "Shift", }, "F11", function () awful.util.spawn( "rofi -show drun" ) end,
  --   {description = "rofi" , group = "function keys" }),
  -- awful.key({ "Shift", }, "F12", function () awful.util.spawn( "Xfce4-terminal --drop-down" ) end,
  --   {description = "dropdown terminal" , group = "specialkeys"}),

  -- Brightness
  awful.key({ }, "XF86MonBrightnessUp", function() awful.spawn.with_shell("~/.config/awesome/scripts/bright-up") end),
            -- {description = "+10%", group = "specialkeys"}),
  awful.key({ }, "XF86MonBrightnessDown", function() awful.spawn.with_shell("~/.config/awesome/scripts/bright-down") end),
            -- {description = "-10%", group = "specialkeys"}),


  awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -D pulse sset Master 5%+", false) end),
  awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -D pulse sset Master 10%-", false) end),
  awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer -D pulse sset Master toggle", false) end),

  --  END Laptop & Special Buttons }}}


  -- Widget Commands:
  -- {{{

  -- awful.key({ modkey }, "=", function() volume_widget:inc() end),
  -- awful.key({ modkey }, "-", function() volume_widget:dec() end),
  -- awful.key({ modkey }, "0", function() volume_widget:toggle() end),

  -- }}}


  -- Touch & Monitors
  -- {{{
  awful.key({ modkey, altkey, "Control" }, "t", function () awful.spawn.with_shell( "~/.config/mybin/touchscreen/reset_matrix.sh"  ) end,
    {description = "touchscreen matrix", group = "System"}),

  awful.key({ modkey, altkey, "Control" }, "t", function () awful.spawn.with_shell( "~/.config/mybin/touchscreen/toggle_touch.sh"  ) end,
    {description = "touchscreen matrix", group = "System"}),

  awful.key({ altkey, "Control" }, "m", function () awful.spawn.with_shell( "~/.config/mybin/monitor-setup.sh"  ) end,
    {description = "monitor setup - laptop/desktop mode", group = "System"}),

  -- }}}

  -- Tests & Probations {{{
  awful.key({ modkey, "Control" }, ",", function ()
        awful.menu({ items = { { "Cancel", function() do end end },
        { "Quit", function() awesome.quit() end } }
      })

    end,
    {description = "FAAAARKS!", group = "awesome"}),

  -- My debugger message to show random whatevers
  -- keep this last because no ","!!!
  awful.key({ altkey, "Control" }, ".",
      function ()
        -- awful.client.incwfact(-0.05)
        naughty.notify { text = "Monitor Count: "..screen.count().." Monitor1: ".. Monitor1 }

        -- text = awful.spawn.with_shell ("~/.config/mybin/fuzzy-clock.sh", 60),
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

)

-- if multiple monitors set up different navigation keys:
if ScreenCount > 1 then
globalkeys = gears.table.join(globalkeys,
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
        {description = "focus right", group = "client"})
)
else
globalkeys = gears.table.join(globalkeys,
  awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
      {description = "focus next by index", group = "client"}),
  awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
      {description = "focus previous by index", group = "client"}),

  -- Make These Smart And Go To Non-empty Tags:
  awful.key({ modkey,           }, "l",   awful.tag.viewnext,
      {description = "view next", group = "tag"}),
  awful.key({ modkey,           }, "h",  awful.tag.viewprev,
      {description = "view previous", group = "tag"})

      -- non lain way??
  -- Non-empty tag browsing
  -- awful.key({ modkey, }, "h", function () lain.util.tag_view_nonempty(-1) end,
  --           {description = "view  previous nonempty", group = "tag"}),
  -- awful.key({ modkey, }, "l", function () lain.util.tag_view_nonempty(1) end,
  --           {description = "view  previous nonempty", group = "tag"}),

)
end

-- Tag Jumping:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
for i = 1, #MyTags do
    -- Hack to only show 1st and last tags in the shortcut window
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end

    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, MyTags[i],
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, MyTags[i],
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, MyTags[i],
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
        awful.key({ modkey, "Control", "Shift" }, MyTags[i],
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

-- Set Keybindings
root.keys(globalkeys)

return globalkeys

-- vim:ft=lua:ts=2:sw=2:sts=2:tw=80:et