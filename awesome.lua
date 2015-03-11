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

--[[
  Your frequently used applications.
Please change if something is not the same ...
]]--
local app={
  ["browser"]="firefox",
  ["terminal"]="xterm",
  ["graphic"]="gimp",
  ["develop"]="gvim",
}

home   = os.getenv("HOME")
terminal,editor,browser,editor_cmd = app.terminal,app.develop,app.browser,app.develop
--[[ 
Global key 
  Mod4 - Win
  Mod1 - Alt
]]--
modkey,altkey = "Mod4","Mod1" 

--[[
  Directory to dynamic images
Please change if something is not the same ...
]]--
local dynamic_wallpaper_dir = '~/Images/Wall'

--[[ 
Status dynamic tags
  true - on dynamic tags
  false - off dynamic tags
]]--
local dynamic_wallpaper = true
local dynamic_tagging = true

-- Standard awesome library
local awful            = require('awful')
local wibox            = require("wibox")
local gears            = require('gears')
-- Theme handling library
local beautiful        = require("beautiful")
-- Notification library
local naughty          = require("naughty")
local lain             = require("lain")
-- Dynamic tagging
if dynamic_tagging then
  require("tags") --dynamic tags config
else
  require("tags_fallback")
end

require("bindings")

function defined(var)
  return var ~= nil
end

-- Theme: defines colours, icons, and wallpapers
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/multicolor/theme.lua")

--- Widgets
local alsawidget       = require('widgets/volume')
local datewidget       = require('widgets/date')
local menulauncher     = require("widgets/menu")
-- {{{ Freedesktop Menu
mymainmenu = awful.menu.new({ items = menugen.build_menu(),
                              theme = { height = 16, width = 130 }})
-- }}}
markup      = lain.util.markup
-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#343639", ">") .. markup("#de5e1e", " %H:%M "))


-- Weather
weathericon = wibox.widget.imagebox(beautiful.widget_weather)
yawn = lain.widgets.yawn(1234567, {
    settings = function()
        widget:set_markup(markup("#eca4c4", forecast:lower() .. " @ " .. units .. "°C "))
    end
})

-- / fs
fsicon = wibox.widget.imagebox(beautiful.widget_fs)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
    end
})

--[[ Mail IMAP check
-- commented because it needs to be set before use
mailicon = wibox.widget.imagebox()
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
mailwidget = lain.widgets.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(beautiful.widget_mail)
            widget:set_markup(markup("#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            mailicon:set_image(nil)
        end
    end
})
]]

-- {{ GMail Widget }} --
mailicon = wibox.widget.imagebox()
vicious.register(mailicon, vicious.widgets.gmail, function(widget, args)
local newMail = tonumber(args["{count}"])
   if newMail > 0 then
     mailicon:set_image(beautiful.mail)
   else
     mailicon:set_image(beautiful.mailopen)
   end
end, 15)

-- CPU
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
    end
})

-- Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#f1af5f", coretemp_now .. "°C "))
    end
})

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    battery="BAT1",
    settings = function()
        if bat_now.perc == "N/A" then
            bat_now.perc = "AC "
        else
            bat_now.perc = bat_now.perc .. "% "
        end
        widget:set_text(bat_now.perc)
    end
})

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
    end
})

-- Net
netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
--netdownicon.align = "middle"
netdowninfo = wibox.widget.textbox()
netupicon = wibox.widget.imagebox(beautiful.widget_netup)
--netupicon.align = "middle"
netupinfo = lain.widgets.net({
    settings = function()
        if iface ~= "network off" and
           string.match(yawn.widget._layout.text, "N/A")
        then
            yawn.fetch_weather()
        end
        widget:set_markup(markup("#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
    end
})

-- MEM
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup("#e0da37", mem_now.used .. "M "))
    end
})

-- MPD
mpdicon = wibox.widget.imagebox()
mpdwidget = lain.widgets.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(beautiful.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(nil)
        end
        widget:set_markup(markup("#e54c62", artist) .. markup("#b2b2b2", title))
    end
})

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

-- Task list
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

-- Small widgets and widget boxes
spacer    = wibox.widget.textbox()
separator = wibox.widget.imagebox()
spacer:set_text(" ")
separator:set_image(beautiful.widget_sep)

-- Wibox initialisation
widgetbox = {}
mybottomwibox = {}
promptbox = {}
layoutbox = {}
taglist   = {}
taglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
)

for s = 1, screen.count() do
  promptbox[s] = awful.widget.prompt()
  -- icon indicating which layout we're using
  layoutbox[s] = awful.widget.layoutbox(s)
  layoutbox[s]:buttons(awful.util.table.join(
  	awful.button({ }, 1, function () awful.layout.inc(awful.layout.layouts, 1) end),
    awful.button({ }, 3, function () awful.layout.inc(awful.layout.layouts, -1) end),
    awful.button({ }, 4, function () awful.layout.inc(awful.layout.layouts, 1) end),
    awful.button({ }, 5, function () awful.layout.inc(awful.layout.layouts, -1) end)
  ))
 
  taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist.buttons)
  mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
  widgetbox[s] = awful.wibox({
		position = "top",
		screen = s,
		fg = beautiful.fg_normal,
		bg = beautiful.bg_normal,
  	border_color = 0,
		border_width = 0
	})

  -- Widgets that are aligned to the left
  local left_layout = wibox.layout.fixed.horizontal()
  --left_layout:add(menulauncher)
  left_layout:add(taglist[s])
  left_layout:add(promptbox[s])

  -- Widgets that are aligned to the right
  local right_layout = wibox.layout.fixed.horizontal()
  if s == 1 then right_layout:add(wibox.widget.systray()) end
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
  right_layout:add(weathericon)
  right_layout:add(yawn.widget)
  right_layout:add(baticon)
  right_layout:add(batwidget)
  right_layout:add(clockicon)
  right_layout:add(mytextclock)

  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  --layout:set_middle(mytasklist[s])
  layout:set_right(right_layout)

  widgetbox[s]:set_widget(layout)
  -- Create the bottom wibox
  mybottomwibox[s] = awful.wibox({ 
    position = "bottom", 
    screen = s, 
    border_width = 0, 
    height = 20 
  })
  -- Widgets that are aligned to the bottom left
  bottom_left_layout = wibox.layout.fixed.horizontal()

  -- Widgets that are aligned to the bottom right
  bottom_right_layout = wibox.layout.fixed.horizontal()
  bottom_right_layout:add(mpdicon)
  bottom_right_layout:add(mpdwidget)

  -- Now bring it all together (with the tasklist in the middle)
  bottom_layout = wibox.layout.align.horizontal()
  bottom_layout:set_left(bottom_left_layout)
  bottom_right_layout:add(layoutbox[s])
  bottom_layout:set_middle(mytasklist[s])
  bottom_layout:set_right(bottom_right_layout)
  mybottomwibox[s]:set_widget(bottom_layout)
end

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    if not awesome.startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)
        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

-- Enable sloppy focus
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--dynamic wallpaper

if beautiful.wallpaper then
	for s = 1,screen.count() do
  	gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end

if dynamic_wallpaper then
	x = 0
	mytimer = timer { timeout = x }
	mytimer:connect_signal("timeout", function()
		local command_for_select = 'find '.. dynamic_wallpaper_dir ..' -type f -name "*.jpg" -o -name "*.png" | shuf -n 1'
		local f = assert(io.popen(command_for_select, 'r'))
	  local filename = assert(f:read('*a'))
	  f:close()
		filename = string.gsub(filename, '[\n\r]+', '')
		for s = 1,screen.count() do
  		gears.wallpaper.maximized(filename, s, true)
		end
  	-- stop the timer (we don't need multiple instances running at the same time)
	  mytimer:stop()
  	-- define the interval in which the next wallpaper change should occur in seconds
	  -- (in this case anytime between 40 and 80 minutes)
  	x = math.random( 2400, 4800)
	  --restart the timer
  	mytimer.timeout = x
	  mytimer:start()
	end)
	-- initial start when rc.lua is first run
	mytimer:start()
end
