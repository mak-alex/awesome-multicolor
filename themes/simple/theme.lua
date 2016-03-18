---- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
local MULTICOLOR = {
  _NAME = "FH-MultiColor",
  _VERSION = 'MULTICOLOR v0.1.0-rc1',
  _URL = 'https://bitbucket.org/enlab/multicolor',
  _MAIL = 'flashhacker1988@gmail.com',
  _LICENSE = [[
    MIT LICENSE
    Copyright (c) 2015 Mikhailenko Alexandr Konstantinovich (a.k.a) Alex M.A.K
    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]],
  _DESCRIPTION = [[
  Multicolor Configuration for the awesome window manager (3.5)
    If you're disappointed by fonts, check your `~/.fonts.conf`.
    It is presumed that you configure your autostart in `~/.xinitrc`.

    ##Capabilities
      * Themes
      * Dynamic wallpaper
      * Test script for hacking
      * Dynamic desktop tagging (via tyrannical)
      * ALSA control (by Rman)
      * Freedesktop menu
      * Multiple desktop support
      * Beautiful notifications (via naughty)

    ##Dependencies
      * beautiful
      * vicious
      * naughty
      * tyrannical (optional)
      * Dynamic generate menu (via Alex M.A.K)
      * Dropdown terminal (via Alex M.A.K)

    ##Widgets
      * alsawidget
      * datewidget
      * menulauncher
      * weather
      * filesystem
      * imap
      * gmail
      * cpu
      * coretemp
      * battery
      * network
      * mem
      * mpd
      * dyna

    HOTKEYS:
    (If you want to change old bindings, open please bindings.lua file and edit...):
                     --------------------------------------
    Operations with MPD servers:
      mpc|ncmpc|pms next:     alt_shift_(arrow_right)
      mpc|ncmpc|pms prev:     alt_shift_(arrow_left)
      mpc|ncmpc|pms toggle:   alt_shift_(arrow_up)
      mpc|ncmpc|pms stop:     alt_shift_(arrow_down)
                     --------------------------------------
    Operations with audio:
      volume up:              alt_(arrow_up)
      volume down:            alt_(arrow_down)
      volume mute:            alt_m
      volumn 100%:            alt_ctrl_m
                     --------------------------------------
    Dynamic tags:
      delete_tag:             win_d
      new tag:                win_n
      new tag with focussed:  win_shift_n
      move to new tag:        win_alt_n
      rename tag to focussed: win_alt_r
      rename tag:             win_shift_r
      term in current  tag:   win_alt_enter
      new tag with term:      win_ctrl_enter
      fork tag:               win_ctrl_f
      aero tag:               win_a
      tag view prev:          win_(arrow_left)
      tag view next:          win_(arrow_right)
      tag history restore:    win_Escape
                     --------------------------------------
    Terminal:
      new terminal:           win_enter
      dropdown terminal:      win_z
                     --------------------------------------
    Window:
      open window fullscreen: win_f
      maximized hor and vert: win_m
      kill window:            win_shift_c
      floating window:        win_ctrl_space
      move left:              win_h
      move right:             win_l
      move up:                win_k
      move down:              win_j
                     --------------------------------------
    Panel:
      hide panels:            win_b
                     --------------------------------------
    Menu:
      open dynamic menu:      win_w
                     --------------------------------------
    Awesome:
      restart wm:             win_ctrl_enter
      quit wm:                win_shift_q
  ]]
}

theme = {}

theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/simple"
theme.icons = os.getenv("HOME") .. "/.config/awesome/icons"
theme.wallpaper = theme.confdir .. "/wall.png"

theme.font = "Hack 9"
--theme.taglist_font =
theme.fg_normal = "#DDDDFF"
theme.fg_focus = "#F0DFAF"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#1A1A1A"
theme.bg_focus = "#313131"
theme.bg_urgent = "#1A1A1A"
theme.border_width = "3"
theme.border_normal = "#3F3F3F"
theme.border_focus = "#7F7F7F"
theme.border_marked = "#CC9393"
theme.titlebar_bg_focus = "#FFFFFF"
theme.titlebar_bg_normal = "#FFFFFF"
theme.taglist_fg_focus = "#D8D782"
theme.tasklist_bg_focus = "#1A1A1A"
theme.tasklist_fg_focus = "#D8D782"
theme.textbox_widget_margin_top = 1
theme.notify_fg = theme.fg_normal
theme.notify_bg = theme.bg_normal
theme.notify_border = theme.border_focus
theme.awful_widget_height = 14
theme.awful_widget_margin_top = 2
theme.mouse_finder_color = "#CC9393"
theme.menu_height = "16"
theme.menu_width = "140"

theme.english = theme.confdir .. "/icons/english.png"
theme.russian = theme.confdir .. "/icons/russian.png"

theme.arrl = theme.confdir .. "/icons/arrl.png"
theme.arrl_dl = theme.confdir .. "/icons/arrl_dl.png"
theme.arrl_ld = theme.confdir .. "/icons/arrl_ld.png"

theme.layout_tile = theme.confdir .. "/layouts/tile.png"
theme.layout_tilebottom = theme.confdir .. "/layouts/tilebottom.png"
theme.layout_floating = theme.confdir .. "/layouts/floating.png"

theme.submenu_icon = theme.confdir .. "/icons/submenu.png"
theme.widget_temp = theme.confdir .. "/icons/temp.png"
theme.widget_uptime = theme.confdir .. "/icons/ac.png"
theme.widget_cpu = theme.confdir .. "/icons/cpu.png"
theme.widget_weather = theme.confdir .. "/icons/dish.png"
theme.widget_fs = theme.confdir .. "/icons/fs.png"
theme.widget_mem = theme.confdir .. "/icons/mem.png"
theme.widget_fs = theme.confdir .. "/icons/fs.png"
theme.widget_note = theme.confdir .. "/icons/note.png"
theme.widget_note_on = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown = theme.confdir .. "/icons/net_down.png"
theme.widget_netup = theme.confdir .. "/icons/net_up.png"
theme.widget_mail = theme.confdir .. "/icons/mail.png"
theme.widget_batt = theme.confdir .. "/icons/bat.png"
theme.widget_clock = theme.confdir .. "/icons/clock.png"
theme.widget_vol = theme.confdir .. "/icons/spkr.png"
theme.widget_ac = theme.confdir .. "/icons/ac.png"
theme.widget_battery = theme.confdir .. "/icons/battery.png"
theme.widget_battery_low = theme.confdir .. "/icons/battery_low.png"
theme.widget_battery_empty = theme.confdir .. "/icons/battery_empty.png"
theme.widget_mem = theme.confdir .. "/icons/mem.png"
theme.widget_net = theme.confdir .. "/icons/net.png"
theme.widget_hdd = theme.confdir .. "/icons/hdd.png"
theme.widget_music = theme.confdir .. "/icons/note.png"
theme.widget_music_on = theme.confdir .. "/icons/note_on.png"
theme.widget_vol_low = theme.confdir .. "/icons/vol_low.png"
theme.widget_vol_no = theme.confdir .. "/icons/vol_no.png"
theme.widget_vol_mute = theme.confdir .. "/icons/vol_mute.png"
theme.widget_mail = theme.confdir .. "/icons/mail.png"
theme.widget_mail_on = theme.confdir .. "/icons/mail_on.png"

theme.widget_arch = theme.icons .. "/blue/arch_10x10.png"

theme.taglist_squares_sel = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/square_b.png"

theme.tasklist_disable_icon = false
tasklist_only_icon = false
theme.tasklist_floating = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical = ""

theme.layout_tile = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle = theme.confdir .. "/icons/dwindle.png"
theme.layout_max = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating = theme.confdir .. "/icons/floating.png"

-- | MPD | --

--[[theme.mpd_prev  = theme.icons .. "/mpd/mpd_prev.png"
theme.mpd_nex   = theme.icons .. "/mpd/mpd_next.png"
theme.mpd_stop  = theme.icons .. "/mpd/mpd_stop.png"
theme.mpd_pause = theme.icons .. "/mpd/mpd_pause.png"
theme.mpd_play  = theme.icons .. "/mpd/mpd_play.png"
theme.mpd_sepr  = theme.icons .. "/mpd/mpd_sepr.png"
theme.mpd_sepl  = theme.icons .. "/mpd/mpd_sepl.png"]]--
theme.mpd = theme.confdir .. "/icons/mpd.png"
theme.mpd_on = theme.confdir .. "/icons/mpd_on.png"
theme.mpd_prev = theme.confdir .. "/icons/prev.png"
theme.mpd_nex = theme.confdir .. "/icons/next.png"
theme.mpd_stop = theme.confdir .. "/icons/stop.png"
theme.mpd_pause = theme.confdir .. "/icons/pause.png"
theme.mpd_play = theme.confdir .. "/icons/play.png"

return theme
