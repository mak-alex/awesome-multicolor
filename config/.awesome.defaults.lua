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
--- {{{ USER CONFIGURATION
--[[
  Your frequently used applications.
Please change if something is not the same ...
]]--
local app={
  ["browser"]="firefox",
  ["terminal"]="urxvt",
  ["graphic"]="gimp",
  ["develop"]="urxvt -e vim",
}
-- Status dynamic tags: true - on dynamic tags / false - off dynamic tags
local dynamic_tagging = true

-- Theme: defines colours, icons, and wallpapers
themename =  "pro-dark" -- "dark" or "multicolor" or "pro-light" or "pro-dark" or "pro-gotham" or "pro-medium-dark" or "pro-medium-light"
---}}}


home = os.getenv("HOME")
terminal,editor,browser,editor_cmd, vksearch = app.terminal,app.develop,app.browser,app.develop, app.musicsearch
-- Global key: Mod4 - Win / Mod1 - Alt
modkey,altkey = "Mod4","Mod1"

-- Standard awesome library
local awful = require('awful')
awful.rules     = require("awful.rules")
                  require("awful.autofocus")
wibox = require("wibox")
gears = require('gears')
vicious           = require("modules.vicious")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
lain = require("modules.lain")
local r = require("modules.runonce")
local dyna = require("modules.dynawall")
-- Dynamic tagging
if dynamic_tagging
then
  require("config/tags")
else
  require("config/tags_fallback")
end

require("config/bindings")
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/"..themename.."/theme.lua")

-- {{{ Widgets
local alsawidget = require('widgets/volume')
local datewidget = require('widgets/date')
local mailhover = require('widgets/mailhover')
--local weather = require('widgets/weather')
require('widgets/filesystem')
local cpu = require('widgets/cpuinfo')
local coretemp = require('widgets/coretemp')
local battery = require('widgets/battery')
local network = require('widgets/network')
local mem = require('widgets/memmory')
require('widgets/mpd')
local kbdcfg = require('widgets/keyboard')

-- }}}

--{{---| Java GUI's fix |---------------------------------------------------------------------------
awful.util.spawn_with_shell("wmname LG3D")

naughty.notify {
  text = "<span color='#e54c62'>Welcome to Multicolor Configuration from Awesome 3.5</span>\n\n<span color='#87af5f'>NAME CONF: </span>"..
  MULTICOLOR._NAME..'\n<span color="#87af5f">VERSION CONF</span>: '..MULTICOLOR._VERSION..'\n<span color="#87af5f">GIT URL</span>: '..
  MULTICOLOR._URL .. "\n\n<span color='#80d9d8'>Coded by Alex M.A.K. (a.k.a) FlashHacker </span> <span color='#7788af'>"..MULTICOLOR._MAIL.."</span>\n",
  ontop = true, border_color = "#7788af", border_width = 3, timeout = 3
}

-- Auto-genereate menu from Awesome configs and plugins --
function createEditConfigurationsFileFromAwesome(name)
  local i, t, popen = 0, {}, io.popen
  for filename in popen ('ls '..name):lines()
  do
    i = i + 1
    t[i] = {
      [filename] = name.."/"..filename
    }
  end

  return t
end

local ConfigFiles = {}
local ThemesFiles = {}
local UserWidgetsFiles = {}
local GlobalWidgetsFiles = {}

if #ConfigFiles == 0 or #ConfigFiles > 2
then
  for k, v in pairs(createEditConfigurationsFileFromAwesome(awful.util.getdir("config")..'/config'))
  do
    for kk, vv in pairs(v)
    do
      table.insert(
        ConfigFiles,
        {
          kk,
          editor_cmd .. " " .. vv,
          settings_icon
        }
      )
    end
  end

  for k, v in pairs(createEditConfigurationsFileFromAwesome(awful.util.getdir("config")..'/themes/'..themename..'/'))
  do
    for kk, vv in pairs(v)
    do
      if string.find(vv, ".lua")
      then
        table.insert(
          ThemesFiles,
          {
            kk,
            editor_cmd .. " " .. vv,
            settings_icon
          }
        )
      end
    end
  end

  for k, v in pairs(createEditConfigurationsFileFromAwesome(awful.util.getdir("config")..'/widgets/'))
  do
    for kk, vv in pairs(v)
    do
      table.insert(
        UserWidgetsFiles,
        {
          kk,
          editor_cmd .. " " .. vv .. '/init.lua',
          settings_icon
        }
      )
    end
  end

  for k, v in pairs(createEditConfigurationsFileFromAwesome(awful.util.getdir("config")..'/modules/lain/widgets/'))
  do
    for kk, vv in pairs(v)
    do
      table.insert(
        GlobalWidgetsFiles,
        {
          kk,
          editor_cmd .. " " .. vv,
          settings_icon
        }
      )
    end
  end
end
-- Autogen Menu
mymainmenu  = awful.menu.new(
  {
    items = menugen.build_menu(),
    theme =
    {
      height = 22,
      width = 240,
      border_width = 3,
      border_color = '#7788af'
    },
    {
      "Awesome",
      {
        {
          "Manual from Awesome",
          terminal .. " -e man awesome",
          help_icon
        },
        { "", },
        {
          "Edit Base Config",
          ConfigFiles,
        },
        {
          "Edit Theme Config",
          ThemesFiles,
        },
        {
          "Edit User Widgets Config",
          UserWidgetsFiles,
        },
        {
          "Edit Global Widgets Config",
          GlobalWidgetsFiles,
        },
        { "", },
        { "Update MultiColor", 'cd '..awful.util.getdir("config")..'; git pull;'},
        { "", },
        {
          "Awesome Restart",
          awesome.restart,
          beautiful.restart_icon
        },
        {
          "Awesome Quit",
          awesome.quit,
          beautiful.quit_icon
        },
      }
    },
    { "", },
    {
         "LockScreen",
         "xlock -mode ant3d",
         nil,
    },
    { "" },
    {
      "Browser",
      "FireFox",
      nil,
    },
    {
      "Terminal",
      terminal,
      nil,
    },
    {
      "FileManager",
      "spacefm",
      nil,
    },
    { "" },
  }
)

-- {{{ Arch icon
archicon = wibox.widget.imagebox()
archicon:set_image(beautiful.widget_arch)
-- }}}
separators = lain.util.separators
-- Separators
spr = wibox.widget.textbox(' ')
arrl = wibox.widget.imagebox()
arrl:set_image(beautiful.arrl)
arrl_dl = separators.arrow_left(beautiful.bg_focus, "alpha")
arrl_ld = separators.arrow_left("alpha", beautiful.bg_focus)

-- | Markup | --
markup = lain.util.markup

space3 = markup.font("Hack 3", " ")
space2 = markup.font("Hack 2", " ")
vspace1 = '<span font="Hack 3"> </span>'
vspace2 = '<span font="Hack 3">  </span>'
clockgf = beautiful.clockgf
require('widgets/mail')
-- | Widgets | --
spr = wibox.widget.imagebox()
spr:set_image(beautiful.spr)
spr4px = wibox.widget.imagebox()
spr4px:set_image(beautiful.spr4px)
spr5px = wibox.widget.imagebox()
spr5px:set_image(beautiful.spr5px)

widget_display = wibox.widget.imagebox()
widget_display:set_image(beautiful.widget_display)
widget_display_r = wibox.widget.imagebox()
widget_display_r:set_image(beautiful.widget_display_r)
widget_display_l = wibox.widget.imagebox()
widget_display_l:set_image(beautiful.widget_display_l)
widget_display_c = wibox.widget.imagebox()
widget_display_c:set_image(beautiful.widget_display_c)

-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#343639", ">") .. markup("#de5e1e", " %H:%M "))

-- Handle runtime errors after startup
do local in_error = false
  awesome.connect_signal(
    "debug::error",
    function (err)
      -- Make sure we don't go into an endless error loop
      if in_error
      then
        return
      end

      in_error = true
      naughty.notify{
        text="<span color='#87af5f'>Awesome crashed during startup on</span> <span color='#e54c62'>" .. os.date("%d/%m/%Y %T</span>:\n\n<span color='#87af5f'>NAME CONF</span>: ")
        ..MULTICOLOR._NAME..'\n<span color="#87af5f">VERSION CONF</span>: '..MULTICOLOR._VERSION..'\n<span color="#87af5f">GIT URL</span>: '..MULTICOLOR._URL .. '\n<span color="#87af5f">ERROR</span>: ' .. err .. "\n\n\
        <span color='#80d9d8'>Please send an error report to</span> <span color='#7788af'>"..MULTICOLOR._MAIL.."</span>\n",
        timeout = 0
      }
      in_error = false
    end
  )
end

-- Task list
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
  awful.button(
    { },
    1,
    function (c)
      if c == client.focus
      then
        c.minimized = true
      else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible()
        then
          awful.tag.viewonly(c:tags()[1])
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
      end
    end
  ),
  awful.button(
    { },
    3,
    function ()
      if instance
      then
        instance:hide()
        instance = nil
      else
        instance = awful.menu.clients(
          {
            theme = {
              width = 250
            }
          }
        )
      end
    end
  ),
  awful.button(
    { },
    4,
    function ()
      awful.client.focus.byidx(1)
      if client.focus
      then
        client.focus:raise()
      end
    end
  ),
  awful.button(
    { },
    5,
    function ()
      awful.client.focus.byidx(-1)
      if client.focus
      then
        client.focus:raise()
      end
    end
  )
)

-- Small widgets and widget boxes
spacer = wibox.widget.textbox()
separator = wibox.widget.imagebox()
spacer:set_text(" ")
separator:set_image(beautiful.widget_sep)

-- Wibox initialisation
widgetbox,mybottomwibox,promptbox,layoutbox,taglist = {},{},{},{},{}
taglist.buttons = awful.util.table.join(
  awful.button(
    { },
    1,
    awful.tag.viewonly
  ),
  awful.button(
    { modkey },
    1,
    awful.client.movetotag
  ),
  awful.button(
    { },
    3,
    awful.tag.viewtoggle
  ),
  awful.button(
    { modkey },
    3,
    awful.client.toggletag
  ),
  awful.button(
    { },
    4,
    function(t)
      awful.tag.viewnext(awful.tag.getscreen(t))
    end
  ),
  awful.button(
    { },
    5,
    function(t)
      awful.tag.viewprev(awful.tag.getscreen(t))
    end
  )
)

for s = 1, screen.count()
do
  promptbox[s] = awful.widget.prompt()
  -- icon indicating which layout we're using
  layoutbox[s] = awful.widget.layoutbox(s)
  layoutbox[s]:buttons(
    awful.util.table.join(
      awful.button(
        { },
        1,
        function ()
          awful.layout.inc(awful.layout.layouts, 1)
        end
      ),
      awful.button(
        { },
        3,
        function ()
          awful.layout.inc(awful.layout.layouts, -1)
        end
      ),
      awful.button(
        { },
        4,
        function ()
          awful.layout.inc(awful.layout.layouts, 1)
        end
      ),
      awful.button(
        { },
        5,
        function ()
          awful.layout.inc(awful.layout.layouts, -1)
        end
      )
    )
  )
  taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist.buttons)
  mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
  widgetbox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, height = 22 })
  --widgetbox[s]:set_widget(layout)

  -- Widgets that are aligned to the left
  local left_layout = wibox.layout.fixed.horizontal()
  if themename == "pro-dark" or themename == "pro-gotham" or themename == "pro-light" or themename == "pro-medium-dark" or themename == "pro-medium-light"
  then
    left_layout:add(spr5px)
    left_layout:add(taglist[s])
    left_layout:add(spr5px)
  else
    left_layout:add(spr)
    left_layout:add(archicon)
    left_layout:add(taglist[s])
    left_layout:add(promptbox[s])
    left_layout:add(spr)
  end
  right_layout = wibox.layout.fixed.horizontal()
  if themename == "dark"
  then
    -- Widgets that are aligned to the upper right
    local right_layout_toggle = true
    local function right_layout_add (...)
      local arg = {...}
      if right_layout_toggle 
      then
        right_layout:add(arrl_ld)
        for i, n in pairs(arg) 
        do
          right_layout:add(wibox.widget.background(n ,beautiful.bg_focus))
        end
      else
        right_layout:add(arrl_dl)
        for i, n in pairs(arg) 
        do
          right_layout:add(n)
        end
      end
      right_layout_toggle = not right_layout_toggle
    end

    -- Widgets that are aligned to the right
    if s == 1
    then
      right_layout:add(wibox.widget.systray())
    end
    right_layout:add(spr)
    right_layout:add(arrl)
    right_layout_add(netdownicon, netdowninfo)
    right_layout_add(netupicon, netupinfo)
    right_layout_add(volicon, volumewidget)
    right_layout_add(memicon, memwidget)
    right_layout_add(cpuicon, cpuwidget)
    right_layout_add(tempicon, tempwidget)
    right_layout_add(fsicon, fswidget)
    right_layout_add(baticon, batwidget)
    right_layout_add(calendar_icon, calendarwidget)
    right_layout_add(clock_icon, clockwidget)
    right_layout_add(kbdcfg.widget)
  elseif themename == "pro-dark" or themename == "pro-gotham" or themename == "pro-light" or themename == "pro-medium-dark" or themename == "pro-medium-light"
  then
    if s == 1 then
        right_layout:add(spr)
        right_layout:add(spr5px)
        right_layout:add(promptbox[s])
        right_layout:add(wibox.widget.systray())
        right_layout:add(spr5px)
    end
    right_layout:add(widget_display_l)
    right_layout:add(kbdcfg_widget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)
    right_layout:add(spr)
    right_layout:add(spr5px)
    right_layout:add(widget_display_l)
    right_layout:add(volumewidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)
    right_layout:add(widget_mail)
    right_layout:add(widget_display_l)
    right_layout:add(mailwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_cpu)
    right_layout:add(widget_display_l)
    right_layout:add(cpuwidget)
    --right_layout:add(widget_display_r)
    right_layout:add(widget_display_c)
    right_layout:add(tmpwidget)
    right_layout:add(widget_tmp)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_mem)
    right_layout:add(widget_display_l)
    right_layout:add(memwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_fs)
    right_layout:add(widget_display_l)
    right_layout:add(fswidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_netdl)
    right_layout:add(widget_display_l)
    right_layout:add(netwidgetdl)
    right_layout:add(widget_display_c)
    right_layout:add(netwidgetul)
    right_layout:add(widget_display_r)
    right_layout:add(widget_netul)

    right_layout:add(spr)

    right_layout:add(widget_clock)
    right_layout:add(widget_display_l)
    right_layout:add(clockwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)
    right_layout:add(spr)
  else
    right_layout:add(spr)
    right_layout:add(arrl)
    right_layout:add(netdownicon)
    right_layout:add(netdowninfo)
    right_layout:add(netupicon)
    right_layout:add(netupinfo)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(tempicon)
    right_layout:add(tempwidget)
    right_layout:add(fsicon)
    right_layout:add(fswidget)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(calendar_icon)
    right_layout:add(calendarwidget)
    right_layout:add(clock_icon)
    right_layout:add(clockwidget)
    right_layout:add(kbdcfg.widget)
  end

  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_right(right_layout)
  widgetbox[s]:set_widget(layout)
  -- Create the bottom wibox
  mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 20 })
  
  -- Widgets that are aligned to the bottom left
  bottom_left_layout = wibox.layout.fixed.horizontal()
  --[[bottom_left_layout:add(spr)
  bottom_left_layout:add(prev_icon)
  bottom_left_layout:add(spr)
  bottom_left_layout:add(stop_icon)
  bottom_left_layout:add(spr)
  bottom_left_layout:add(play_pause_icon)
  bottom_left_layout:add(spr)
  bottom_left_layout:add(next_icon)]]
  --bottom_left_layout:add(mpd_sepl)
  --bottom_left_layout:add(musicwidget)
  --bottom_left_layout:add(mpd_sepr)
  
  -- Widgets that are aligned to the bottom right
  bottom_right_layout = wibox.layout.fixed.horizontal()
  --bottom_right_layout:add(mpdicon) 
  --bottom_right_layout:add(musicwidget)
  bottom_right_layout:add(musicwidget.widget)
  bottom_right_layout:add(layoutbox[s])

  -- Now bring it all together (with the tasklist in the middle)
  bottom_layout = wibox.layout.align.horizontal()
  bottom_layout:set_left(bottom_left_layout)
  bottom_layout:set_middle(mytasklist[s])
  bottom_layout:set_right(bottom_right_layout)
  mybottomwibox[s]:set_bg(beautiful.panel)
  mybottomwibox[s]:set_widget(bottom_layout)
end

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
  "manage",
  function (c)
    c:connect_signal(
      "mouse::enter",
      function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c)
        then
          client.focus = c
        end
      end
    )

    if not startup
    then
      if not c.size_hints.user_position and not c.size_hints.program_position
      then
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
      end
    end

    if not awesome.startup
    then
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      -- awful.client.setslave(c)
      -- Put windows in a smart way, only if they does not set an initial position.
      if not c.size_hints.user_position and not c.size_hints.program_position
      then
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
      end
    end
  end
)

-- Enable sloppy focus
client.connect_signal(
  "mouse::enter",
  function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c)
    then
      client.focus = c
    end
  end
)

client.connect_signal(
  "focus",
  function(c)
    c.border_color = beautiful.border_focus
  end
)

client.connect_signal(
  "unfocus",
  function(c)
    c.border_color = beautiful.border_normal
  end
)
-- }}}

-- Default static wall
if beautiful.wallpaper
then
  for s = 1,screen.count()
  do
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
  end
end
