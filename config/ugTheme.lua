local awful                     = require("awful")
local theme_assets              = require("beautiful.theme_assets")
-- local gears                     = require("gears")
local dpi                       = require("beautiful.xresources").apply_dpi
-- local theme_dir                 = require("gears.filesystem").get_themes_dir()
-- local ico_dir                   = theme_dir.."default/layouts/"
local ico_dir                   = "/usr/share/icons/Adwaita/22x22/"

-- local lay_dir      = theme_dir.."default/layouts/"
-- beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")
awful.spawn.with_shell("nitrogen --random --set-zoom-fill ~/.config/awesome/img/wallpaper/dark")

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

local theme                     = {}

theme.font                      = ThemeFont .. " 10"
theme.tasklist_disable_icon     = true
theme.icon_theme                = "/usr/share/icons/ePapirus/22x22/"
-- theme.wallpaper             = os.getenv("HOME") .. "/.config/awesome/wallpapers/default.jpg"
-- theme.wallpaper             = os.getenv("HOME") .. Wallpaper

theme.fg_normal                 = Clite
theme.bg_normal                 = Cdark
theme.fg_focus                  = Cliter
theme.bg_focus                  = Cdarkr

theme.hotkeys_fg                = Clite
theme.hotkeys_modifiers_fg      = Cinfo
theme.hotkeys_font              = ThemeFont .. " 11"
theme.hotkeys_description_font  = ThemeFont .. " 10"
theme.hotkeys_border_width      = 2
theme.hotkeys_border_color      = Cmain
theme.hotkeys_bg                = Cdark
theme.hotkeys_margin            = 0
theme.hotkeys_padding           = 10
theme.hotkeys_show_title        = true
theme.hotkeys_show_help         = true
theme.hotkeys_fullscreen        = true

theme.bg_urgent                 = Cwarn
theme.bg_minimize               = theme.bg_normal

theme.border_width              = dpi(1)
theme.border_focus              = Cmain
theme.border_normal             = Cdark
theme.border_marked             = Cinfo

theme.taglist_spacing           = 2
theme.taglist_font              = ThemeFont .. " 9"
theme.taglist_fg_normal         = theme.fg_normal
theme.taglist_bg_normal         = theme.bg_normal
theme.taglist_fg_focus          = Cliter
theme.taglist_bg_focus          = Cmain
theme.taglist_bg_occupied       = Cdarkr
theme.taglist_bg_urgent         = Cerr
theme.taglist_bg_empty          = theme.bg_normal
theme.titlebar_bg_normal        = Cdark
theme.titlebar_bg_focus         = Cdarkr
theme.bg_systray                = theme.bg_normal

theme.useless_gap               = 5

theme.menu_height               = dpi(19)
theme.menu_width                = dpi(330)
theme.menu_font                 = ThemeFont .. " 10"

-- Generate taglist: {{{
-- -- Use All Tags: {{{
-- local taglist_square_size = dpi(6)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )
-- }}}

-- Only show tags with stuff on them {{{
local orig_filter               = awful.widget.taglist.filter.all
awful.widget.taglist.filter.all = function (t, args)
  if t.selected or #t:clients() > 0 then
    return orig_filter(t, args)
  end
end
-- }}}
-- Generate taglist }}}

-- Layout Icons:
-- {{{
theme.layout_fairh              = ico_dir.."fairhw.png"
theme.layout_fairv              = ico_dir.."fairvw.png"
theme.layout_floating           = ico_dir.."floatingw.png"
theme.layout_magnifier          = ico_dir.."magnifierw.png"
theme.layout_max                = ico_dir.."maxw.png"
theme.layout_fullscreen         = ico_dir.."fullscreenw.png"
theme.layout_tilebottom         = ico_dir.."tilebottomw.png"
theme.layout_tileleft           = ico_dir.."tileleftw.png"
theme.layout_tile               = ico_dir.."tilew.png"
theme.layout_tiletop            = ico_dir.."tiletopw.png"
theme.layout_spiral             = ico_dir.."spiralw.png"
theme.layout_dwindle            = ico_dir.."dwindlew.png"
theme.layout_cornernw           = ico_dir.."cornernww.png"
theme.layout_cornerne           = ico_dir.."cornernew.png"
theme.layout_cornersw           = ico_dir.."cornersww.png"
theme.layout_cornerse           = ico_dir.."cornersew.png"
-- }}}

-- Generate Awesome icon:
theme.awesome_icon              = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)
