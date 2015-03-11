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
                     --------------------------------------
    And more...
      If you're here, read the code ;-)
  ]]
}
local awful = require('awful')
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
local beautiful = require("beautiful")
drop      = require("scratchdrop")
menugen = require("menugen")
tyrannical = require("tyrannical")
local capi      = {root=root,client=client,tag=tag,mouse=mouse}
local ipairs    = ipairs
local unpack    = unpack
local aw_util   = require( "awful.util"   )
local aw_tag    = require( "awful.tag"    )
local aw_client = require( "awful.client" )
local aw_layout = require( "awful.layout" )
local aw_key    = require( "awful.key"    )
local aw_prompt = require( "awful.prompt" )
local glib      = require( "lgi"          ).GLib

-- Delete a tag as of 3.5.5, this have a few issue. Patches are on their way
local function delete_tag()
    aw_tag.delete(capi.client.focus and aw_tag.selected(capi.client.focus.screen) or aw_tag.selected(capi.mouse.screen) )
end

-- Create a new tag at the end of the list
local function new_tag()
    aw_tag.viewonly(aw_tag.add("NewTag",{screen= (capi.client.focus and capi.client.focus.screen or capi.mouse.screen) }))
end

local function new_tag_with_focussed()
    local c = capi.client.focus
    local t = aw_tag.add(c.class,{screen= (capi.client.focus and capi.client.focus.screen or capi.mouse.screen),layout=aw_layout.suit.tile })
    if c then c:tags(aw_util.table.join(c:tags(), {t})) end
    aw_tag.viewonly(t)
end

local function move_to_new_tag()
    local c = capi.client.focus
    local t = aw_tag.add(c.class,{screen= (capi.client.focus and capi.client.focus.screen or capi.mouse.screen) })
    if c then
        c:tags({t})
        aw_tag.viewonly(t)
    end
end

local function rename_tag_to_focussed()
    if capi.client.focus then
        local t = aw_tag.selected(capi.client.focus.screen)
        t.name = capi.client.focus.class
    end
end

local function rename_tag()
    aw_prompt.run({ prompt = "New tag name: " },
        promptbox[capi.mouse.screen].widget,
        function(new_name)
            if not new_name or #new_name == 0 then
                return
            else
                local screen = capi.mouse.screen
                local t = aw_tag.selected(screen)
                if t then
                    t.name = new_name
                end
            end
        end
    )
end

local function term_in_current_tag()
    aw_util.spawn(terminal,{intrusive=true,slave=true})
end

local function new_tag_with_term()
    aw_util.spawn(terminal,{new_tag={volatile = true}})
end

local function fork_tag()
    local s = capi.client.focus and capi.client.focus.screen or capi.mouse.screen
    local t = aw_tag.selected(s)
    if not t then return end
    local clients = t:clients()
    local t2 = aw_tag.add(t.name,aw_tag.getdata(t))
    t2:clients(clients)
    aw_tag.viewonly(t2)
end

local function aero_tag()
    local c = capi.client.focus
    if not c then return end
    local c2 = aw_client.data.focus[2]
    if (not c2) or c2 == c then return end
    local t = aw_tag.add("Aero",{screen= c.screen ,layout=aw_layout.suit.tile,mwfact=0.5})
    t:clients({c,c2})
    aw_tag.viewonly(t)
end

local function register_keys()
    local keys = {}
    -- Comment the lines of the shortcut you don't want
    for _,data in  ipairs {
        {{ modkey            }, "d"     , delete_tag            },
        {{ modkey            }, "n"     , new_tag               },
        {{ modkey, "Shift"   }, "n"     , new_tag_with_focussed },
        {{ modkey, "Mod1"    }, "n"     , move_to_new_tag       },
        {{ modkey, "Mod1"    }, "r"     , rename_tag_to_focussed},
        {{ modkey, "Shift"   }, "r"     , rename_tag            },
        {{ modkey, "Mod1"    }, "Return", term_in_current_tag   },
        {{ modkey, "Control" }, "Return", new_tag_with_term     },
        {{ modkey, "Control" }, "f"     , fork_tag              },
        {{ modkey            }, "a"     , aero_tag              },
    } do
        keys[#keys+1] = aw_key(data[1], data[2], data[3])
    end
    capi.root.keys(aw_util.table.join(capi.root.keys(),unpack(keys)))
end


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
	awful.button({ }, 3, function () mymainmenu:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local globalkeys = awful.util.table.join(
    globalkeys,
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "u",      awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "n",      function ()
      awful.client.focus.byidx( 1)
      if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey,           }, "k",      function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "b",                 function ()
      widgetbox[mouse.screen].visible = not widgetbox[mouse.screen].visible
      mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end),
    awful.key({ modkey,           }, "Tab",    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end),
    awful.key({ modkey,           }, "j",
      function ()
        awful.client.focus.byidx( 1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey,           }, "k",
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),
    -- Dropdown terminal
    awful.key({ modkey,           }, "z",      function () drop(terminal,250,nil,700,250) end),
     -- Show Menu
    awful.key({ modkey }, "w",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),
    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function ()
            awful.util.spawn("amixer -q set Master 1%+")
            volumewidget.update()
        end),
    awful.key({ altkey }, "Down",
        function ()
            awful.util.spawn("amixer -q set Master 1%-")
            volumewidget.update()
        end),
    awful.key({ altkey }, "m",
        function ()
            awful.util.spawn("amixer -q set Master playback toggle")
            volumewidget.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            awful.util.spawn("amixer -q set Master playback 100%")
            volumewidget.update()
        end),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
            mpdwidget.update()
        end),


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    -- Layout manipulation
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(awful.layout.layouts, 1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(awful.layout.layouts, -1) end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    awful.key({ modkey },            "r",     function () promptbox[mouse.screen]:run() end),
    awful.key({ modkey },            "o",     function ()
        local promptbox = promptbox[mouse.screen];
        awful.prompt.run(
          {prompt = "<span>Open: </span>"},
          promptbox.widget,
          function (command)
          local space = command:match(" ");
          if space then
          command = 'https://www.google.com/search?q='..command;
          end
          awful.util.spawn(browser .. ' "' .. command .. '"')
          end,
          awful.completion.shell,
          --awful.util.getdir("cCache").."/history"
          awful.util.getdir("cCache")
          )
    end)
) --end globalkeys

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]
        if tag then
          awful.tag.viewonly(tag)
        end
      end),
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        local tag = awful.tag.gettags(client.focus.screen)[i]
        if client.focus and tag then
          awful.client.movetotag(tag)
        end
      end),
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        local tag = awful.tag.gettags(client.focus.screen)[i]
        if client.focus and tag then
          awful.client.toggletag(tag)
        end
      end
    )
  )
end

local clientkeys = awful.util.table.join(
    clientkeys,
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "m",      function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
    end)
)

local clientbuttons = awful.util.table.join(clientbuttons,
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Register keys
root.keys(globalkeys)

-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientkeys,
      buttons = clientbuttons
    }
  },
}

glib.idle_add(glib.PRIORITY_DEFAULT_IDLE, register_keys)