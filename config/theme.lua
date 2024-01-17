local awful       = require("awful")
local beautiful   = require("beautiful")
local themes_path = require("gears.filesystem").get_themes_dir()
local dpi         = require("beautiful.xresources").apply_dpi
-- local gears     = require("gears")

awful.spawn.with_shell("nitrogen --random --set-zoom-fill ~/.config/awesome/img/wallpaper/dark")

-- {{{ Set Vars
local theme = {}
theme.awesome_icon      = themes_path .. "zenburn/awesome-icon.png"
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.icon_theme        = "/usr/share/icons/breeze-dark/"
--[[
#361C0E
#570211
#7E3110
#004540
#032C4D
#360825

#020412
#510513
#6a040f

#041275;
#040f45;

#DCDCCC;
#FDDFFF;

--  FAK:
better words:
Text
Text Notice
Text Muted
Text Warning
Main
Accent
Borders
Notice
Muted
Urgent
Trans
Trans Accent

--]]

local light    = "#ECECCC"
local lightr   = "#F9F1ED"
local bright   = "#FFFFFF"

local main     = "#032C4D"
local trans    = "#032C4D99"
local second   = "#361C0E"
local trans2   = "#361C0E99"
local urgent   = "#7E3110"
local success  = "#004540"
local warn     = "#6a040f"

local dark     = "#040f45"
local darkr    = "#020412"
local fontface = "Hack NF"

theme.font      = fontface .. " 9"
theme.bg_systray        = main
theme.systray_icon_size = dpi(14)

-- }}}

-- {{{ Colors
theme.fg_normal  = light
theme.fg_focus   = lightr
theme.fg_urgent  = bright
theme.bg_normal  = main
theme.bg_focus   = main
theme.bg_urgent  = urgent
theme.bg_systray = main
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(1)
theme.border_width  = dpi(3)
theme.border_normal = dark
theme.border_focus  = success
theme.border_marked = warn
-- }}}

-- Hotkeys popup {{{
theme.hotkeys_fg            = lightr
theme.hotkeys_modifiers_fg  = bright
theme.hotkeys_font          = fontface .. " 10"
theme.hotkeys_description_font = fontface .. " 12"
theme.hotkeys_border_width = dpi(4)
theme.hotkeys_border_color = second
theme.hotkeys_bg = trans
theme.hotkeys_margin = 0
theme.hotkeys_padding = 10
theme.hotkeys_show_title = true
theme.hotkeys_show_help = true
theme.hotkeys_fullscreen = true
-- }}}

-- {{{ TaskList
-- [tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
theme.tasklist_font              = fontface .. ", Italic 10"
theme.tasklist_spacing           = dpi(4)
theme.tasklist_fg_normal         = theme.fg_normal
theme.tasklist_bg_normal         = theme.bg_normal
theme.tasklist_fg_focus          = bright
theme.tasklist_bg_focus          = success
theme.tasklist_bg_occupied       = dark
theme.tasklist_bg_urgent         = urgent
theme.tasklist_bg_empty          = trans

-- }}}

-- {{{ TagList
theme.taglist_spacing           = 0
theme.taglist_font              = fontface .. ", Bold 10"
theme.taglist_fg_normal         = light
theme.taglist_bg_normal         = trans
theme.taglist_fg_focus          = bright
theme.taglist_bg_focus          = success
theme.taglist_bg_occupied       = dark
theme.taglist_bg_urgent         = urgent
theme.taglist_bg_empty          = trans
theme.taglist_bg_volatile       = warn

local orig_filter               = awful.widget.taglist.filter.all
awful.widget.taglist.filter.all = function (t, args)
  if t.selected or #t:clients() > 0 then
    return orig_filter(t, args)
  end
end
-- }}}

-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Layout Icon
theme.layout_tile       = themes_path .. "zenburn/layouts/tile.png"
theme.layout_tileleft   = themes_path .. "zenburn/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "zenburn/layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "zenburn/layouts/fairv.png"
theme.layout_fairh      = themes_path .. "zenburn/layouts/fairh.png"
theme.layout_spiral     = themes_path .. "zenburn/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "zenburn/layouts/dwindle.png"
theme.layout_max        = themes_path .. "zenburn/layouts/max.png"
theme.layout_fullscreen = themes_path .. "zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "zenburn/layouts/magnifier.png"
theme.layout_floating   = themes_path .. "zenburn/layouts/floating.png"
theme.layout_cornernw   = themes_path .. "zenburn/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "zenburn/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "zenburn/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "zenburn/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_bg_normal    = dark
theme.titlebar_bg_focus     = darkr

theme.titlebar_close_button_focus  = themes_path .. "zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "zenburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "zenburn/titlebar/maximized_normal_inactive.png"
-- }}}

beautiful.init(theme)
