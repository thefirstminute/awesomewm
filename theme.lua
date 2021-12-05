-- Initial Vars & Incs: {{{
-- local vicious  = require("vicious")
-- local gears    = require("gears")
local lain     = require("lain")
local awful    = require("awful")
local wibox    = require("wibox")
local dpi      = require("beautiful.xresources").apply_dpi

-- local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme_font  = "Hack"

local markup   = lain.util.markup
local theme    = {}

-- Separators
local SPC   = wibox.widget.textbox(markup.font(theme_font .. " 4", " "))
local PIPE  = wibox.widget.textbox(markup.font(theme_font .. " 3", " ") .. markup.fontfg(theme_font, "#666666", "|") .. markup.font(theme_font .. " 5", " "))

-- Widgets etc...
local apt_widget = require("awesome-wm-widgets.apt-widget.apt-widget")

local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
-- local word_clock = require("awesome-wm-widgets.word-clock-widget.word-clock")
-- }}}


-- Theme Variables {{{
theme.default_dir           = require("awful.util").get_themes_dir() .. "default/"
theme.dir                   = os.getenv("HOME") .. "/.config/awesome/themes/copland"
-- theme.icon_dir              = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons/"
theme.icon_dir              = os.getenv("HOME") .. "/.config/awesome/themes/copland/icons/"
theme.widget_dir            = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow/icons/"

theme.wallpaper             = os.getenv("HOME") .. "/.config/awesome/wallpapers/0204.jpg"
theme.font                  = theme_font
theme.useless_gap           = 3
theme.border_width          = dpi(1)
theme.menu_height           = dpi(18)
theme.menu_width            = dpi(330)
theme.tasklist_disable_icon = true
-- Colours {{{
theme.fg_normal             = "#BBBBBB"
theme.fg_focus              = "#78A4FF"
theme.bg_normal             = "#111111"
theme.bg_focus              = "#111111"
theme.fg_urgent             = "#000000"
theme.bg_urgent             = "#FFFFFF"
theme.border_normal         = "#141414"
theme.border_focus          = "#93B6FF"
theme.taglist_fg_focus      = "#FFFFFF"
theme.taglist_bg_focus      = "#111111"
theme.taglist_bg_normal     = "#111111"
theme.titlebar_bg_normal    = "#191919"
theme.titlebar_bg_focus     = "#262626"

--[[
#000000
#111111
#191919
#262626
#78A4FF
#93B6FF
#BBBBBB
#FFFFFF
--]]

-- }}}
-- Misc Widget & Theme Icons {{{
theme.awesome_icon                              = theme.icon_dir .. "awesome_icon_white.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "awesome_icon.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "square_unsel.png"
theme.spr_small                                 = theme.icon_dir .. "spr_small.png"
theme.spr_very_small                            = theme.icon_dir .. "spr_very_small.png"
theme.spr_right                                 = theme.icon_dir .. "spr_right.png"
theme.spr_bottom_right                          = theme.icon_dir .. "spr_bottom_right.png"
theme.spr_left                                  = theme.icon_dir .. "spr_left.png"
theme.bar                                       = theme.icon_dir .. "bar.png"
theme.bottom_bar                                = theme.icon_dir .. "bottom_bar.png"
theme.mpdl                                      = theme.icon_dir .. "mpd.png"
theme.mpd_on                                    = theme.icon_dir .. "mpd_on.png"
theme.prev                                      = theme.icon_dir .. "prev.png"
theme.nex                                       = theme.icon_dir .. "next.png"
theme.stop                                      = theme.icon_dir .. "stop.png"
theme.pause                                     = theme.icon_dir .. "pause.png"
theme.play                                      = theme.icon_dir .. "play.png"
-- theme.clock                                     = theme.icon_dir .. "clock.png"
theme.calendar                                  = theme.icon_dir .. "cal.png"

-- theme.cpu                                       = theme.icon_dir .. "cpu.png"
-- theme.net_up                                    = theme.icon_dir .. "net_up.png"
-- theme.net_down                                  = theme.icon_dir .. "net_down.png"
-- theme.bat                                       = theme.icon_dir .. "bat.png"
-- theme.bat_low                                   = theme.icon_dir .. "bat_low.png"
-- theme.bat_no                                    = theme.icon_dir .. "bat_no.png"

theme.widget_ac                                 = theme.widget_dir .. "ac.png"
theme.widget_battery                            = theme.widget_dir .. "battery.png"
theme.widget_battery_low                        = theme.widget_dir .. "battery_low.png"
theme.widget_battery_empty                      = theme.widget_dir .. "battery_empty.png"
theme.widget_mem                                = theme.widget_dir .. "mem.png"
theme.widget_cpu                                = theme.widget_dir .. "cpu.png"
theme.widget_temp                               = theme.widget_dir .. "temp.png"
theme.widget_net                                = theme.widget_dir .. "net.png"
theme.widget_hdd                                = theme.widget_dir .. "hdd.png"
theme.widget_music                              = theme.widget_dir .. "note.png"
theme.widget_music_on                           = theme.widget_dir .. "note.png"
theme.widget_music_pause                        = theme.widget_dir .. "pause.png"
theme.widget_music_stop                         = theme.widget_dir .. "stop.png"
theme.widget_vol                                = theme.widget_dir .. "vol.png"
theme.widget_vol_low                            = theme.widget_dir .. "vol_low.png"
theme.widget_vol_no                             = theme.widget_dir .. "vol_no.png"
theme.widget_vol_mute                           = theme.widget_dir .. "vol_mute.png"
theme.widget_mail                               = theme.widget_dir .. "mail.png"
theme.widget_mail_on                            = theme.widget_dir .. "mail_on.png"
theme.widget_task                               = theme.widget_dir .. "task.png"
theme.widget_scissors                           = theme.widget_dir .. "scissors.png"
theme.widget_weather                            = theme.widget_dir .. "dish.png"


theme.layout_tile                               = theme.icon_dir .. "tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "dwindle.png"
theme.layout_max                                = theme.icon_dir .. "max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "floating.png"

theme.titlebar_close_button_normal              = theme.default_dir .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.default_dir .. "titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.default_dir .. "titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.default_dir .. "titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.default_dir .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.default_dir .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.default_dir .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.default_dir .. "titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.default_dir .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.default_dir .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.default_dir .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.default_dir .. "titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.default_dir .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.default_dir .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.default_dir .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.default_dir .. "titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_dir .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_dir .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.default_dir .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.default_dir .. "titlebar/maximized_focus_active.png"



-- END ICONS }}}
-- END Theme Variables }}}


-- Widgets & Stuff {{{

-- Only show tags with stuff on them {{{
-- Eminent-like task filtering
local orig_filter = awful.widget.taglist.filter.all
-- Taglist label functions
awful.widget.taglist.filter.all = function (t, args)
    if t.selected or #t:clients() > 0 then
        return orig_filter(t, args)
    end
end
-- }}}

-- Date & Time{{{
--os.setlocale(os.getenv("LANG")) -- to localize the clock

-- local fuzzTime = wibox.widget{
--     text = awful.spawn.with_shell ("~/.config/mybin/fuzzy-clock.sh", 60),
--     widget = wibox.widget.textbox
-- }
-- fuzzTime.font = theme.font .. " 10"

local myTime = wibox.widget.textclock(" %a %d %b %R ", 60)
myTime.font = theme.font .. " 10"

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { myTime },
    notification_preset = {
        font = theme.font .. " 11",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})


-- }}}

-- {{{ ALSA volume

-- local volicon = wibox.widget.imagebox(theme.vol)
-- theme.volume = lain.widget.alsabar {
--     width = dpi(59), border_width = 0, ticks = true, ticks_size = dpi(6),
--     notification_preset = { font = theme.font },
--     --togglechannel = "IEC958,3",
--     settings = function()
--         if volume_now.status == "off" then
--             volicon:set_image(theme.vol_mute)
--         elseif volume_now.level == 0 then
--             volicon:set_image(theme.vol_no)
--         elseif volume_now.level <= 50 then
--             volicon:set_image(theme.vol_low)
--         else
--             volicon:set_image(theme.vol)
--         end
--     end,
--     colors = {
--         background   = theme.bg_normal,
--         mute         = red,
--         unmute       = theme.fg_normal
--     }
-- }
-- theme.volume.tooltip.wibox.fg = theme.fg_focus
-- theme.volume.bar:buttons(my_table.join (
--           awful.button({}, 1, function()
--             awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
--           end),
--           awful.button({}, 2, function()
--             os.execute(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
--             theme.volume.update()
--           end),
--           awful.button({}, 3, function()
--             os.execute(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
--             theme.volume.update()
--           end),
--           awful.button({}, 4, function()
--             os.execute(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
--             theme.volume.update()
--           end),
--           awful.button({}, 5, function()
--             os.execute(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
--             theme.volume.update()
--           end)
-- ))
-- local volumebg = wibox.container.background(theme.volume.bar, "#474747", gears.shape.rectangle)
-- local volumewidget = wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))

-- }}}

-- {{{ Resources:

-- {{{ Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    timeout = 2,
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, " AC"))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 9 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 20 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% " .. bat_now.time .. " Remaining"))
            -- widget:set_markup(markup.font(theme.font, " " .. bat_now.time .. " Remaining"))
        else
            baticon:set_image(theme.widget_battery)
            widget:set_markup(markup.font(theme.font, " --- "))
        end
    end
})

-- }}}

-- {{{ NET
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    timeout = 4,
    settings = function()
        widget:set_markup(markup.font(theme.font, net_now.received .. " ↓↑ " .. net_now.sent))
    end
})

-- }}}

-- {{{ CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    timeout = 8,
    settings = function()
        widget:set_markup(markup.font(theme.font, cpu_now.usage .. "%"))
    end
})

-- }}}

-- {{{ MEM
-- https://www.reddit.com/r/awesomewm/comments/klfd8q/awesomewm_ram_widget/
-- awful.widget.watch('bash -c "free -h | awk \'/^Mem/ {print $3 $2}\'"' ,30),

local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    timeout = 12,
    settings = function()
      widget:set_markup(markup.font(theme.font, string.format("%.1f",mem_now.used/1000) .. "G (" .. math.floor((mem_now.used/7670*100)) .. "%)"))
    end
})

-- }}}
-- }}} END Resources

-- }}} END Widgets & Stuff


function theme.at_screen_connect(s)
  -- {{{
  -- barvars: {{{
    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
    -- Open tags with layouts in order
    -- awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Image Layout Icons For Each Screen
    s.mylayoutbox = awful.widget.layoutbox(s)

    -- Create taglist
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create tasklist
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(16), bg = theme.bg_normal, fg = theme.fg_normal })

  -- }}}


  -- right side of wibox with monitor 1 logics: {{{
    if s == screen.primary then
      WiboxRight=
      {
        layout = wibox.layout.fixed.horizontal,

        wibox.container.background(wibox.container.margin(wibox.widget {
          nil, neticon, net.widget, layout = wibox.layout.align.horizontal
        }, dpi(3), dpi(3)), ""),


        PIPE,

        -- SPC,
        -- wibox.container.background(wibox.container.margin(wibox.widget {
        --   BatIcon, bat.widget, layout = wibox.layout.align.horizontal
        -- }, dpi(3), dpi(3)), ""),

        wibox.container.background(wibox.container.margin(wibox.widget {
          cpuicon, cpu.widget, layout = wibox.layout.align.horizontal
        }, dpi(3), dpi(4)), ""),


        SPC,
        wibox.container.background(wibox.container.margin(wibox.widget {
          memicon, mem.widget, layout = wibox.layout.align.horizontal
        }, dpi(2), dpi(3)), ""),

        PIPE,
        wibox.container.background(wibox.container.margin(wibox.widget {
          baticon, bat.widget, layout = wibox.layout.align.horizontal
        }, dpi(3), dpi(3)), ""),


        -- SPC,
        -- volumebar_widget(),
        -- wibox.container.background(wibox.container.margin(wibox.widget {
        --   volicon, theme.volume.widget, layout = wibox.layout.align.horizontal
        -- }, dpi(2), dpi(3)), ""),


        PIPE,
        volume_widget(),


        PIPE,
        apt_widget(),

        -- PIPE,
        myTime,

        wibox.widget.systray(),
        SPC,


        s.mylayoutbox,
      }

    else
      WiboxRight=
      {
        layout = wibox.layout.fixed.horizontal,
        s.mylayoutbox,
      }
    end

  -- }}}


  -- {{{ Add widgets to the wibox
    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
        SPC,
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget

      WiboxRight
    }
  -- }}}


end

  -- }}}

return theme
