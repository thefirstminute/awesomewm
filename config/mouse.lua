local awful = require("awful")
local gears = require("gears")
local menu  = require("config.menu")
local terminal  = require("config.vars").terminal

-- {{{
-- TODO: still not going away when you click off, or right click...
local task_switcher_menu = nil -- Variable to keep track of the menu
local last_scroll_time = 0     -- Variable to store the time of the last scroll action
local function show_task_switcher_menu()
  local clients = client.get()
  local menu_items = {}

  for _, c in ipairs(clients) do
    local client_item = {
      c.name or c.class or "Unnamed",
      function()
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        c:tags()[1]:view_only()
        task_switcher_menu:hide()         -- Hide the menu after clicking a client
      end
    }
    table.insert(menu_items, client_item)
  end

  task_switcher_menu = awful.menu({
    items = menu_items,
    theme = { width = 200 }
  })

  -- Add a handler to hide the menu when clicked outside of it
  task_switcher_menu.wibox:connect_signal("button::press", function(_, _, _, button)
    if button == 3 then     -- Button 3 is right-click
      task_switcher_menu:hide()
    end
  end)

  -- Show the menu only if a certain time has passed since the last scroll action
  local current_time = os.time()
  if current_time - last_scroll_time >= 2 then
    task_switcher_menu:show()
    last_scroll_time = current_time
  end
end
-- }}}

root.buttons(gears.table.join(
  awful.button({}, 3, function() menu:toggle() end),
  -- awful.button({ }, 4, awful.tag.viewnext),
  -- awful.button({ }, 5, awful.tag.viewprev),
  awful.button({}, 4, function()
    show_task_switcher_menu()
  end),
  awful.button({}, 5, function()
    show_task_switcher_menu()
  end),


  awful.button({}, 8, function()
    awful.spawn("thorium-browser")
  end),
  awful.button({}, 9, function()
    awful.spawn(terminal)
  end)
))

