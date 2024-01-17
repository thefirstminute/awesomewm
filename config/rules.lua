local awful = require("awful")
local beautiful = require("beautiful")
local clientkeys = require("config.clientkeys")
local clientbuttons = require("config.clientbuttons")

awful.rules.rules = {
  -- All clients will match this rule.
  -- {{{
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }, -- }}}

  -- Titlebars
  -- {{{
  {
    rule_any = { type = { "normal", "dialog" }
    },
    properties = { titlebars_enabled = false }
  }, -- }}}

  -- Floating clients.
  -- {{{
  {
    rule_any = {
      instance = {
        "DTA",   -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer" },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  }, -- end floating clients }}}

  -- Floating clients but centered in screen
  -- {{{
  {
    rule_any = {
      class = {
        "Arandr",
        "Galculator",
        "Gnome-calculator",
        "Gnome-calendar",
        "Polkit-gnome-authentication-agent-1",
        "Xfce4-terminal"
      },
      name = {
        "Site Manager",          -- filezilla
        "Synchronized browsing", -- filezilla
      },
    },
    properties = { screen = Monitor3, floating = true },
    callback = function(c)
      awful.placement.centered(c, nil)
    end
  }, -- }}}

  -- Custom rules for specific applications
  -- {{{
  { rule = { name = "ktimetracker" },
    -- {{{
    properties = {
      screen = Monitor3,
      tag = "[",
      floating = true,
      switchtotag = false,
      width = 850,
      height = 500,
      placement = awful.placement.top_right
    }
  }, -- }}}

  { rule = { name = "Barrier" },
    -- {{{
    properties = {
      screen = Monitor3,
      tag = "[",
      floating = true,
      switchtotag = false,
      placement = awful.placement.bottom_right + awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }, -- }}}

  { rule = { name = "GoForIt!" },
    -- {{{
    properties = {
      screen = Monitor3,
      tag = "[",
      maximized = false,
      floating = true,
      switchtotag = false,
      width = 400,
      height = 500,
      placement = awful.placement.top_left
    }
  }, -- }}}

  { rule = { class = "TelegramDesktop" },
    -- {{{
      properties = {
        screen = Monitor3,
        tag = ";",
        switchtotag = false
      }
  },-- }}}

  { rule = { class = "Skype" },
    -- {{{
      properties = {
        screen = Monitor3,
        tag = "'",
        switchtotag = false
      }
},-- }}}

  { rule = { class = "VirtualBox Machine" },
    -- {{{
    properties = {
      screen = Monitor2,
      tag = ";",
      switchtotag = false
    }
  },-- }}}

  { rule = { class = "VirtualBox Manager" },
    -- {{{
      properties = {
        screen = Monitor2,
        tag = "'",
        switchtotag = false
      }
},-- }}}

  { rule = { class = "rofi" },
    -- {{{
    properties = {
      screen = Monitor3,
      switchtotag = true
    }
  },-- }}}

  { rule = { class = "Chromium" },
    -- {{{
      properties = {
        screen = Monitor3,
        tag = "y",
        switchtotag = true,
        floating = false,
        maximized = false
      }
  },-- }}}

  { rule = { class = "thorium-browser" },
    -- {{{
      properties = {
        switchtotag = true,
        floating = false,
        maximized = false
      }
  },-- }}}

  { rule = { class = "Vivaldi-stable" },
    -- {{{
    properties = {
      screen = Monitor3,
      tag = "p",
      switchtotag = false,
      floating = false,
      maximized = false
    }
  },-- }}}

  -- firefox
  -- {{{
  { rule = { class = "Firefox" },
    -- {{{
    properties = {
      screen = Monitor3,
      tag = "i",
      switchtotag = true,
      floating = false,
      maximized = false
    },
    callback = function(c)
      awful.placement.centered(c, nil)
    end
  },-- }}}

  -- firefox downloads:
  { rule = { class = "Firefox", name = "Library" },
    -- {{{
      properties = {
        screen = Monitor3,
        floating = true
      },
      callback = function(c)
        awful.placement.centered(c, nil)
      end
},-- }}}

-- firefox upload/file select:
  { rule = { class = "Firefox", name = "File Upload" },
    -- {{{
    properties = {
      screen = Monitor3,
      floating = true,
      switchtotag = true
    },
    callback = function(c)
      awful.placement.centered(c, nil)
    end
  },-- }}}

-- }}}

  { rule = { class = "waterfox-g3" },
    -- {{{
    properties = {
      screen = Monitor1,
      tag = "[",
      switchtotag = false,
      maximized = false
    }
  }-- }}}


  -- end custom rules for specific applications }}}

}
