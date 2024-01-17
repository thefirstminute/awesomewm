local awful = require("awful")
local gears = require("gears")
local modkey = require("config.vars").modkey
local altkey = require("config.vars").altkey

return gears.table.join(

  -- force tiling to work:
  awful.key({ modkey, "Shift" }, "t",
    function(c)
      c.maximized_horizontal = false
      c.maximized_vertical   = false
      c.maximized            = false
      c.floating             = false
    end,
    { description = "force tiling", group = "client" }),

  awful.key({ modkey, "Shift" }, "=",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),

  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
    { description = "close", group = "client" }),

  awful.key({ modkey, }, "q", function(c) c:kill() end,
    { description = "quit", group = "client" }),

  awful.key({ altkey, }, "Backspace", function(c) c:kill() end,
    { description = "kill", group = "client" }),

  awful.key({ modkey, "Shift" }, "f", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }),

  awful.key({ modkey, "Shift" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),

  awful.key({ modkey, "Shift" }, ".", function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }),

  awful.key({ modkey, "Shift" }, "t", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),

  awful.key({ modkey, "Shift" }, "-",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),

  awful.key({ modkey, }, "-", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal(
        "request::activate", "key.unminimize", { raise = true }
      )
    end
  end, { description = "restore minimized", group = "client" })

  -- awful.key({ modkey, "Shift"   }, "v",
  -- function (c)
  --   c.maximized_vertical = not c.maximized_vertical
  --   c:raise()
  -- end ,
  -- {description = "(un)maximize vertically", group = "client"}),

  -- awful.key({ modkey, "Shift"   }, "z",
  -- function (c)
  --   c.maximized_horizontal = not c.maximized_horizontal
  --   c:raise()
  -- end ,
  -- {description = "(un)maximize horizontally", group = "client"}),

  -- awful.key({ modkey, "Shift" }, "m",
  --   function(c)
  --     c.maximized = not c.maximized
  --     c:raise()
  --   end,
  --   { description = "(un)maximize", group = "client" })

)
