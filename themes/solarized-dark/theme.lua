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

theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/solarized-dark"
theme.icons = os.getenv("HOME") .. "/.config/awesome/themes/solarized-dark/icons"
theme.wallpaper = theme.confdir .. "/wall.png"

-- | AWESOME WM | --
theme.awesomewm = theme.icons .. '/awesomewm.png'
theme.lockscreen = theme.icons .. '/lockscreen.png'
theme.browser = theme.icons .. '/browser.png'
theme.console = theme.icons .. '/console.png'
theme.filemanager = theme.icons .. '/filemanager.png'
theme.email = theme.icons .. '/email.png'
theme.awesomeManual = theme.icons .. '/awesomeManual.png'
theme.sourceEdit = theme.icons .. '/sourceEdit.png'
theme.file = theme.icons .. '/file.png'
theme.updateAwesome = theme.icons .. '/updateAwesome.png'
theme.themesAwesome = theme.icons .. '/themesAwesome.png'
theme.poweroff = theme.icons .. '/poweroff.png'
theme.restart = theme.icons .. '/restart.png'
theme.applications = theme.icons .. '/applications.png'
theme.lualogo = theme.icons .. '/luaLogo.png'
theme.cloud9 = theme.icons .. '/cloud9.png'
theme.develop = theme.icons .. '/develop.png'
-- | GOOGLE APPS | --
theme.google_apps = theme.icons .. '/google/google_apps.png'
--
theme.play_books = theme.icons .. '/google/play_book.png'
theme.play_docs = theme.icons .. '/google/play_doc.png'
theme.play_sheets = theme.icons .. '/google/play_sheet.png'
theme.play_forms = theme.icons .. '/google/play_form.png'
theme.play_slides = theme.icons .. '/google/play_slide.png'
theme.play_drawings = theme.icons .. '/google/play_drawing.png'
theme.play_drive = theme.icons .. '/google/play_drive.png'
theme.play_hangouts = theme.icons .. '/google/play_hangouts.png'
theme.play_calendar = theme.icons .. '/google/play_calendar.png'
theme.play_news = theme.icons .. '/google/play_news.png'
theme.play_contacts = theme.icons .. '/google/play_contacts.png'
theme.play_inbox = theme.icons .. '/google/play_inbox.png'

theme.radio_yandex = theme.icons .. '/radio.yandex.png'
theme.music_yandex = theme.icons .. '/music.yandex.png'
theme.music = theme.icons .. '/music.png'
theme.ru101 = theme.icons .. '/101.png'
theme.di = theme.icons .. '/di.png'
theme.photoeditor = theme.icons .. '/photoeditor.png'
theme.im = theme.icons .. '/im.png'

theme.font = "Ohsnap 9"

theme.english = theme.confdir .. "/icons/english.png"
theme.russian = theme.confdir .. "/icons/russian.png"

theme.colors = {}
theme.colors.base3   = "#002b36ff"
theme.colors.base2   = "#073642ff"
theme.colors.base1   = "#586e75ff"
theme.colors.base0   = "#657b83ff"
theme.colors.base00  = "#839496ff"
theme.colors.base01  = "#93a1a1ff"
theme.colors.base02  = "#eee8d5ff"
theme.colors.base03  = "#fdf6e3ff"
theme.colors.yellow  = "#b58900ff"
theme.colors.orange  = "#cb4b16ff"
theme.colors.red     = "#dc322fff"
theme.colors.magenta = "#d33682ff"
theme.colors.violet  = "#6c71c4ff"
theme.colors.blue    = "#268bd2ff"
theme.colors.cyan    = "#2aa198ff"
theme.colors.green   = "#859900ff"

--theme.taglist_font =
-- {{{ Colors
theme.fg_normal  = theme.colors.base02
theme.fg_focus   = theme.colors.base03
theme.fg_urgent  = theme.colors.base3

theme.bg_normal  = theme.colors.base3
theme.bg_focus   = theme.colors.base1
theme.bg_urgent  = theme.colors.red
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = theme.colors.green
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

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

theme.widget_arch = theme.icons .. "/blue/arch.png"

theme.mpd = theme.confdir .. "/icons/mpd.png"
theme.mpd_on = theme.confdir .. "/icons/mpd_on.png"
theme.prev = theme.confdir .. "/icons/prev.png"
theme.nex = theme.confdir .. "/icons/next.png"
theme.stop = theme.confdir .. "/icons/stop.png"
theme.pause = theme.confdir .. "/icons/pause.png"
theme.play = theme.confdir .. "/icons/play.png"

theme.taglist_squares_sel = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/square_b.png"

theme.tasklist_disable_icon = true
tasklist_only_icon = true
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

return theme
