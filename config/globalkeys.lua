local client        = client
local awesome       = awesome

local gears         = require("gears")
local awful         = require("awful")
-- local lain          = require("lain")
local naughty       = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
local modkey        = require("config.vars").modkey
local altkey        = require("config.vars").altkey
local terminal      = require("config.vars").terminal
local filemanager   = require("config.vars").filemanager
local mytags        = require("config.tags")

-- System Command:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
local globalkeys    = gears.table.join(

  awful.key({ altkey, "Control" }, "/", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),

  awful.key({ altkey, "Control" }, "Return", function() awful.spawn("xfce4-terminal --drop-down") end,
    { description = "dropdown terminal", group = "launch" }),

  awful.key({ altkey, "Control" }, "w",
    function() awful.spawn.with_shell("nitrogen --random --set-zoom-fill ~/.config/awesome/img/wallpaper") end,
    { description = "wallpaper", group = "system" }),

  awful.key({ altkey, "Control" }, "r", awesome.restart,
    { description = "reload awesome", group = "system" }),

  awful.key({ altkey, "Control" }, "l", function() awful.spawn.with_shell(". ~/.config/rofi/scripts/power.sh") end,
    { description = "Log-Out", group = "system" }),

  awful.key({ altkey, "Control" }, "n", function() naughty.destroy_all_notifications() end,
    { description = "Kill notifications", group = "system" }),

  -- Brightness {{{
  awful.key({ altkey, "Control" }, "Right", function() awful.spawn.with_shell("~/.config/awesome/scripts/bright-up") end,
    { description = "Brightness Up", group = "system" }),
  awful.key({ altkey, "Control" }, "Left", function() awful.spawn.with_shell("~/.config/awesome/scripts/bright-down") end,
    { description = "Brightness Down", group = "system" }),
  -- awful.key({ altkey, "Control" }, "Right", function () awful.spawn("xbacklight -inc 10") end,
  --     {description = "Brightness Up", group = "system"}),
  -- awful.key({ altkey, "Control" }, "Left", function () awful.spawn("xbacklight -dec 10") end,
  --     {description = "Brightness Down", group = "system"}),

  --}}}

  -- Volume Controls {{{
  -- pactl seemed to go louder...
  -- awful.key({ altkey, "Control" }, "Up", function () awful.spawn("amixer -D pulse sset Master 5%+", false) end,
  --     {description = "Volume Up", group = "system"}),
  -- awful.key({ altkey, "Control" }, "Down", function () awful.spawn("amixer -D pulse sset Master 10%-", false) end,
  --     {description = "Volume Down", group = "system"}),

  awful.key({ altkey, "Control" }, "v", function() awful.spawn("amixer -D pulse sset Master toggle", false) end,
    { description = "Volume Toggle", group = "system" }),
  awful.key({ altkey, "Control" }, "Up", function() awful.spawn("pactl -- set-sink-volume 0 +5%", false) end,
    { description = "Volume Up", group = "system" }),
  awful.key({ altkey, "Control" }, "Down", function() awful.spawn("pactl -- set-sink-volume 0 -20%", false) end,
    { description = "Volume Down", group = "system" }),

  -- }}}

  -- Touch & Monitors
  -- {{{
  awful.key({ altkey, "Control" }, "m",
    function() awful.spawn.with_shell("~/.config/mybin/touchscreen/reset_matrix.sh") end,
    { description = "touchscreen matrix", group = "system" }),
  awful.key({ modkey, altkey }, "t",
    function() awful.spawn.with_shell("~/.config/mybin/touchscreen/toggle_touch.sh") end,
    { description = "touchscreen toggle", group = "system" }),
  awful.key({ altkey, "Control" }, "t", function() awful.spawn.with_shell("~/.config/mybin/toggle-touchpad.sh") end,
    { description = "touchpad toggle", group = "system" }),
  awful.key({ modkey, "Control" }, "m", function() awful.spawn.with_shell("~/.config/mybin/monitor-setup.sh") end,
    { description = "monitor setup - laptop/desktop mode", group = "system" }),

  -- }}}


  -- Show/Hide Wibox
  awful.key({ altkey, "Control" }, "b", function()
      for s in screen do
        s.mywibox.visible = not s.mywibox.visible
        if s.mybottomwibox then
          s.mybottomwibox.visible = not s.mybottomwibox.visible
        end
      end
    end,
    { description = "toggle wibox", group = "system" }),

  awful.key({ altkey, "Control" }, ".",
    function()
      -- awful.client.incwfact(-0.05)
      -- naughty.notify { text = "Monitor Count: "..screen.count().." Current Screen: ".. Monitor1 }

      -- naughty.notify { text = "Current Screen: ".. mouse.screen }

      local screen_count = screen.count()
      local focused_screen = awful.screen.focused()
      local current_screen = focused_screen.index
      local current_tag = focused_screen.selected_tag.name

      local notification_text = string.format(
        "Screens: %d\n Screen #: %d\nTag: %s",
        screen_count, current_screen, current_tag
      )

      naughty.notify {
        title = "Screen and Tag Info",
        text = notification_text,
        timeout = 9,   -- You can adjust the timeout as needed
        position = "top_right",
      }

      -- text = awful.spawn.with_shell ("~/.config/mybin/fuzzy-clock.sh", 60),
      -- naughty.notify { text = "Time: "..awful.spawn.easy_async(terminal.." -e ./.config/mybin/fuzzy-clock.sh") }
      -- naughty.notify { text = "Time: "..awful.spawn(" ./.config/mybin/fuzzy-clock.sh") }
      -- naughty.notify { text = "Time: "..awful.spawn.with_line_callback(terminal.." ./.config/mybin/fuzzy-clock.sh") }
      -- naughty.notify { text = "Time: "..awful.spawn("~/.config/mybin/fuzzy-clock.sh") }
      -- naughty.notify { text = "Time: "..awful.spawn("~/.config/mybin/fuzzy-clock.sh") }
      -- naughty.notify { text = "Time: "..awful.spawn("~/.config/mybin/fuzzy-clock.sh") }
      -- naughty.notify { text = "Time: "..awful.spawn.with_shell ("$HOME/.config/mybin/fuzzy-clock.sh") }
    end
  )
)


-- }}}

-- Launch:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
globalkeys = gears.table.join(globalkeys,

  -- {{{ Mod+Alt+

  awful.key({ modkey, altkey }, "f", function() awful.spawn(filemanager) end,
    { description = "File Manager", group = "launch" }),

  awful.key({ modkey, altkey }, "Return", function() awful.spawn(terminal .. " -e fish") end,
    { description = "terminal with fish shell", group = "launch" }),
  awful.key({ modkey, altkey }, "t", function() awful.spawn("flatpak run org.telegram.desktop") end,
    { description = "telegram", group = "launch" }),

  -- Mouse Control:
  -- {{{
  awful.key({ modkey, altkey }, "y", function() awful.spawn("xdotool mousemove 0 0") end,
    { description = "move mouse to top corner", group = "Mousey" }),
  awful.key({ modkey, altkey }, "n", function() awful.spawn.with_shell("~/.config/mybin/mouse-move.sh center") end,
    { description = "Move Mouse Begin", group = "Mousey" }),
  awful.key({ modkey, altkey }, "h", function() awful.spawn.with_shell("~/.config/mybin/mouse-move.sh Left") end,
    { description = "Move Mouse Left", group = "Mousey" }),
  awful.key({ modkey, altkey }, "l", function() awful.spawn.with_shell("~/.config/mybin/mouse-move.sh Right") end,
    { description = "Move Mouse Right", group = "Mousey" }),
  awful.key({ modkey, altkey }, "k", function() awful.spawn.with_shell("~/.config/mybin/mouse-move.sh Up") end,
    { description = "Move Mouse Up", group = "Mousey" }),
  awful.key({ modkey, altkey }, "j", function() awful.spawn.with_shell("~/.config/mybin/mouse-move.sh Down") end,
    { description = "Move Mouse Down", group = "Mousey" }),
  awful.key({ modkey }, "BackSpace", function() awful.spawn.with_shell("~/.config/mybin/mouse-move.sh bravead") end,
    { description = "Kill Brave Ad", group = "Mousey" }),
  awful.key({ modkey, altkey }, "\\",
    function() awful.spawn.with_shell("~/.config/mybin/mouse-move.sh no-waterfox-update") end,
    { description = "No WF Update!", group = "Mousey" }),
  awful.key({ modkey, altkey }, "u", function() awful.spawn.with_shell("~/.config/mybin/mouse-click.sh left") end),
  awful.key({ modkey, altkey }, "i", function() awful.spawn.with_shell("~/.config/mybin/mouse-click.sh middle") end),
  awful.key({ modkey, altkey }, "o", function() awful.spawn.with_shell("~/.config/mybin/mouse-click.sh right") end),
  -- end mouse control }}}

  -- Super+Alt+ }}}

  -- {{{ Alt+

  awful.key({ altkey }, "v", function() awful.spawn(terminal .. " -e vifm") end,
    { description = "ViFM", group = "launch" }),

  --}}}

  -- {{{ Mod+

  -- Screen Focus
  -- {{{
  awful.key({ modkey }, ".", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey }, ",", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  -- }}}

  awful.key({ modkey, }, "t", function() awful.spawn('xfce4-terminal') end,
    { description = "floating terminal", group = "launch" }),


  -- Mod+ }}}

  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = terminal, group = "launch" })
)
-- }}}

-- Space Launch:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
--  FAK: Make it smarter so it doesn't launch something that is already running!
globalkeys = gears.table.join(globalkeys,
  awful.key({ modkey }, " ", function()
    local focused_screen = awful.screen.focused()
    local current_screen = focused_screen.index
    local current_tag = focused_screen.selected_tag.name
    local launch_app = "thorium-browser"
    local search_app = ""
    local screen_count = screen.count()

    if screen_count > 1 then
      if current_screen == 1 then
        -- {{{
        if current_tag == "y" then
          launch_app = "gnome-www-browser"
        elseif current_tag == "u" then
          launch_app = "filezilla"
        elseif current_tag == "i" then
          launch_app = "firefox"
        elseif current_tag == "o" then
          launch_app = "flatpak run com.microsoft.Edge"
          search_app = "microsoft-edge"
        elseif current_tag == "p" then
          launch_app = "vivaldi-stable"
        elseif current_tag == ";" then
          launch_app = "flatpak run org.telegram.desktop"
        search_app = "telegram"
        end
        -- }}}
      elseif current_screen == 2 then
        -- {{{
        if current_tag == ";" then
          launch_app = "thunderbird"
        elseif current_tag == "p" then
          launch_app = "thunderbird"
        end
        -- }}}
      end
    else   -- Single Screen:
      if current_tag == "u" then
        launch_app = "filezilla"
      elseif current_tag == "i" then
        launch_app = terminal
      elseif current_tag == "o" then
        launch_app = "firefox"
      elseif current_tag == "p" then
        launch_app = "vivaldi-stable"
      elseif current_tag == ";" then
        launch_app = "flatpak run org.telegram.desktop"
        search_app = "telegram"
      elseif current_tag == "'" then
        launch_app = "thunderbird"
      end
    end

    if search_app == "" then
      search_app = launch_app
    end

    naughty.notify {
      title = "Launch Info...",
      text = string.format("Screens: %d\n Screen #: %d\nTag: %s\nBrowser: %s", screen_count, current_screen, current_tag, search_app),
      timeout = 9,
      position = "bottom_left",
    }

    -- if search_app is running switch to it, else launch it
    local running = awful.spawn.easy_async_with_shell("pgrep -f " .. search_app)
    if running ~= "" then
      awful.spawn(launch_app)
    else
      awful.spawn.with_shell("xdotool search --class " .. search_app .. " windowactivate")
    end

  end, { description = "Space Launcher", group = "launch" })
)
-- }}}

-- Rofi!:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
globalkeys = gears.table.join(globalkeys,

  awful.key({ altkey }, "t", function() awful.spawn.with_shell(". ~/.config/rofi/scripts/kand_text.sh") end,
    { description = "canned text", group = "rofi" }),

  awful.key({ altkey }, "s", function() awful.spawn.with_shell(". ~/.config/rofi/scripts/snippets.sh") end,
    { description = "snippets", group = "rofi" }),

  awful.key({ altkey }, "c", function() awful.spawn.with_shell(". ~/.config/rofi/scripts/clipboard.sh") end,
    { description = "clipboard", group = "rofi" }),

  awful.key({ modkey }, "s", function() awful.spawn.with_shell("rofi -show combi") end,
    { description = "combi", group = "rofi" }),

  awful.key({ altkey }, "r", function() awful.spawn.with_shell("rofi -show combi") end,
    { description = "combi", group = "rofi" }),

  awful.key({ altkey }, "w", function() awful.spawn.with_shell(". ~/.config/rofi/scripts/web_search.sh") end,
    { description = "Web Search", group = "rofi" }),

  awful.key({ modkey }, "w", function() awful.spawn("rofi -show window") end,
    { description = "window", group = "rofi" })

)
-- }}}

-- Client:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
globalkeys = gears.table.join(globalkeys,

  awful.key({ modkey,           }, "\\", function () awful.layout.inc( 1)     end,
    { description = "select next", group = "layout" }),

  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width", group = "layout" }),

  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width", group = "layout" }),

  awful.key({ altkey, "Control" }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent", group = "client" })

)

if ScreenCount > 1 then
  globalkeys = gears.table.join(globalkeys,
    awful.key({ modkey }, "j",
      function()
        awful.client.focus.global_bydirection("down")
        if client.focus then client.focus:raise() end
      end,
      { description = "focus down", group = "client" }),

    awful.key({ modkey }, "k",
      function()
        awful.client.focus.global_bydirection("up")
        if client.focus then client.focus:raise() end
      end,
      { description = "focus up", group = "client" }),

    awful.key({ modkey }, "h",
      function()
        awful.client.focus.global_bydirection("left")
        if client.focus then client.focus:raise() end
      end,
      { description = "focus left", group = "client" }),

    awful.key({ modkey }, "l",
      function()
        awful.client.focus.global_bydirection("right")
        if client.focus then client.focus:raise() end
      end,
      { description = "focus right", group = "client" })
  )
else
  globalkeys = gears.table.join(globalkeys,

    awful.key({ modkey, }, "j", function() awful.client.focus.byidx(1) end,
      { description = "focus next by index", group = "client" }),
    awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end,
      { description = "focus previous by index", group = "client" })

  -- awful.key({ modkey, }, "h", function() lain.util.tag_view_nonempty(-1) end,
  --   { description = "view  previous nonempty", group = "tag" }),
  -- awful.key({ modkey, }, "l", function() lain.util.tag_view_nonempty(1) end,
  --   { description = "view  previous nonempty", group = "tag" })

  )
end
-- }}}

-- Laptop & Special Keys:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{

globalkeys = gears.table.join(globalkeys,
  awful.key({}, "Print", function() awful.spawn("xfce4-screenshooter") end,
    { description = "Xfce screenshot", group = "specialkeys" }),

  awful.key({}, "F9", function() awful.spawn("xfce4-terminal --drop-down") end,
    { description = "dropdown terminal", group = "specialkeys" }),

  -- Brightness
  awful.key({}, "XF86MonBrightnessUp", function() awful.spawn.with_shell("~/.config/awesome/scripts/bright-up") end),
  -- {description = "+10%", group = "specialkeys"}),
  awful.key({}, "XF86MonBrightnessDown", function() awful.spawn.with_shell("~/.config/awesome/scripts/bright-down") end),
  -- {description = "-10%", group = "specialkeys"}),


  -- awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn("amixer -D pulse sset Master 5%+", false) end),
  -- awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn("amixer -D pulse sset Master 10%-", false) end),
  awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn("pactl -- set-sink-volume 0 +5%", false) end),
  awful.key({}, "XF86AudioLowerVolume", function() awful.spawn("pactl -- set-sink-volume 0 -20%", false) end),
  awful.key({}, "XF86AudioMute", function() awful.spawn("amixer -D pulse sset Master toggle", false) end),
  awful.key({}, "XF86Calculator", function() awful.spawn("gnome-calculator") end),
  awful.key({ modkey }, "XF86Favorites",
    function() awful.spawn.with_shell("~/Applications/waterfox-g3-2.7-48.10.Build48.14.glibc2.17-x86_64.AppImage") end),
  awful.key({}, "XF86Favorites", function() awful.spawn.with_shell("~/.config/mybin/close-waterfox.sh") end)

)

-- }}}

-- Tag Jumping & Manipulation:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{
for i = 1, #mytags do
  -- Hack to only show 1st and last tags in the shortcut window
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 then
    descr_view = { description = "view tag #", group = "tag" }
    descr_toggle = { description = "toggle tag #", group = "tag" }
    descr_move = { description = "move focused client to tag #", group = "tag" }
    descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
  end

  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, mytags[i],
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      descr_view),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, mytags[i],
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      descr_toggle),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, mytags[i],
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      descr_move)
  -- Toggle tag on focused client.
  -- No Clue What This Does
  -- awful.key({ modkey, altkey, "Control" }, mytags[i],
  --   function()
  --     if client.focus then
  --       local tag = client.focus.screen.tags[i]
  --       if tag then
  --         client.focus:toggle_tag(tag)
  --       end
  --     end
  --   end,
  --   descr_toggle_focus)
  )
end
-- END Tag jumping }}}

-- Testing:    ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪
-- {{{


-- }}}


root.keys(globalkeys)
