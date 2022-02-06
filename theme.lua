-- options: {{{
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
-- }}}

local awful        = require("awful")
local theme_assets = require("beautiful.theme_assets")
local dpi          = require("beautiful.xresources").apply_dpi
local theme_dir    = require("gears.filesystem").get_themes_dir()
local ico_dir      = theme_dir.."default/layouts/"
-- local lay_dir      = theme_dir.."default/layouts/"

local theme = {}

theme.font                  = ThemeFont .. " 12"
theme.tasklist_disable_icon = true
theme.icon_theme            = "/usr/share/icons/ePapirus/22x22/"
theme.wallpaper             = os.getenv("HOME") .. "/.config/awesome/wallpapers/default.jpg"

theme.fg_normal             = Clite
theme.bg_normal             = Cdark
theme.fg_focus              = Cliter
theme.bg_focus              = Cdarkr

theme.bg_urgent             = Cwarn
theme.bg_minimize           = theme.bg_normal

theme.border_width          = dpi(1)
theme.border_focus          = Cmain
theme.border_normal         = Cdark
theme.border_marked         = Cinfo

theme.taglist_spacing       = 2
theme.taglist_font          = ThemeFont .. " 9"
theme.taglist_fg_normal     = theme.fg_normal
theme.taglist_bg_normal     = theme.bg_normal
theme.taglist_fg_focus      = Cliter
theme.taglist_bg_focus      = Cmain
theme.taglist_bg_occupied   = Cdarkr
theme.taglist_bg_urgent     = Cerr
theme.taglist_bg_empty      = theme.bg_normal
theme.titlebar_bg_normal    = Cdark
theme.titlebar_bg_focus     = Cdarkr
theme.bg_systray            = theme.bg_normal

theme.useless_gap           = 5

theme.menu_height           = dpi(19)
theme.menu_width            = dpi(330)
theme.menu_font             = ThemeFont .. " 10"


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
local orig_filter = awful.widget.taglist.filter.all
awful.widget.taglist.filter.all = function (t, args)
  if t.selected or #t:clients() > 0 then
    return orig_filter(t, args)
  end
end
-- }}}
-- Generate taglist }}}

-- Layout Icons:
-- {{{
theme.layout_fairh      = ico_dir.."fairhw.png"
theme.layout_fairv      = ico_dir.."fairvw.png"
theme.layout_floating   = ico_dir.."floatingw.png"
theme.layout_magnifier  = ico_dir.."magnifierw.png"
theme.layout_max        = ico_dir.."maxw.png"
theme.layout_fullscreen = ico_dir.."fullscreenw.png"
theme.layout_tilebottom = ico_dir.."tilebottomw.png"
theme.layout_tileleft   = ico_dir.."tileleftw.png"
theme.layout_tile       = ico_dir.."tilew.png"
theme.layout_tiletop    = ico_dir.."tiletopw.png"
theme.layout_spiral     = ico_dir.."spiralw.png"
theme.layout_dwindle    = ico_dir.."dwindlew.png"
theme.layout_cornernw   = ico_dir.."cornernww.png"
theme.layout_cornerne   = ico_dir.."cornernew.png"
theme.layout_cornersw   = ico_dir.."cornersww.png"
theme.layout_cornerse   = ico_dir.."cornersew.png"
-- }}}

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

return theme
