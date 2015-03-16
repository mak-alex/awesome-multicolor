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
           
    Operations with MPD servers:
      mpc|ncmpc|pms next:     Alt+Shift+(arrow_right)
      mpc|ncmpc|pms prev:     Alt+Shift+(arrow_left)
      mpc|ncmpc|pms toggle:   Alt+Shift+(arrow_up)
      mpc|ncmpc|pms stop:     Alt+Shift+(arrow_down)
           
    Operations with audio:
      volume up:              Alt+(arrow_up)
      volume down:            Alt+(arrow_down)
      volume mute:            Alt+m
      volumn 100%:            Alt+Ctrl+m
           
    Dynamic tags:
      delete_tag:             Win+d
      new tag:                Win+n
      new tag with focussed:  Win+Shift+n
      move to new tag:        Win+Alt+n
      rename tag to focussed: Win+Alt+r
      rename tag:             Win+Shift+r
      term in current  tag:   Win+Alt+enter
      new tag with term:      Win+Ctrl+enter
      fork tag:               Win+Ctrl+f
      aero tag:               Win+a
      tag view prev:          Win+(arrow_left)
      tag view next:          Win+(arrow_right)
      tag history restore:    Win+Escape
           
    Terminal:
      new terminal:           Win+enter
      dropdown terminal:      Win+z
           
    Window:
      open window fullscreen: Win+f
      maximized hor and vert: Win+m
      kill window:            Win+Shift+c
      floating window:        Win+Ctrl+space
           
    Panel:
      hide panels:            Win+b
           
    Menu:
      open dynamic menu:      Win+w
           
    Awesome:
      restart wm:             Win+Ctrl+enter
      quit wm:                Win+Shift+q
           
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

local function hotKeys()
  naughty.notify({ 
    text = [[
    <span font="ohsnap 13" color='#87af5f'><b>MPD (MUSIC SERVER):</b></span>
      <span font="" color='#e33a6e'>mpc|ncmpc|pms next:</span>     <span font="" color='#87af5f'>Alt+Shift+(arrow_right)</span>
      <span font="" color='#e33a6e'>mpc|ncmpc|pms prev:</span>     <span font="" color='#87af5f'>Alt+Shift+(arrow_left)</span>
      <span font="" color='#e33a6e'>mpc|ncmpc|pms toggle:</span>   <span font="" color='#87af5f'>Alt+Shift+(arrow_up)</span>
      <span font="" color='#e33a6e'>mpc|ncmpc|pms stop:</span>     <span font="" color='#87af5f'>Alt+Shift+(arrow_down)</span>

    <span font="ohsnap 13" color='#e54c62'><b>ALSA:</b></span>
      <span font="" color='#f1af5f'>volume up:</span>              <span font="" color='#e54c62'>Alt+(arrow_up)</span>
      <span font="" color='#f1af5f'>volume down:</span>            <span font="" color='#e54c62'>Alt+(arrow_down)</span>
      <span font="" color='#f1af5f'>volume mute|unmute:</span>     <span font="" color='#e54c62'>Alt+m</span>
      <span font="" color='#f1af5f'>volumn 100%:</span>            <span font="" color='#e54c62'>Alt+Ctrl+m</span>
            
    <span font="ohsnap 13" color='#7493d2'><b>DYNAMIC TAGS:</b></span>
      <span font="" color='#80d9d8'>delete_tag:</span>             <span font="" color='#7493d2'>Win+d</span>
      <span font="" color='#80d9d8'>new tag:</span>                <span font="" color='#7493d2'>Win+n</span>
      <span font="" color='#80d9d8'>move to new tag:</span>        <span font="" color='#7493d2'>Win+Alt+n</span>
      <span font="" color='#80d9d8'>rename tag to focussed:</span> <span font="" color='#7493d2'>Win+Alt+r</span>
      <span font="" color='#80d9d8'>rename tag:</span>             <span font="" color='#7493d2'>Win+Shift+r</span>
      <span font="" color='#80d9d8'>term in current  tag:</span>   <span font="" color='#7493d2'>Win+Alt+enter</span>
      <span font="" color='#80d9d8'>new tag with term:</span>      <span font="" color='#7493d2'>Win+Ctrl+enter</span>
      <span font="" color='#80d9d8'>fork tag:</span>               <span font="" color='#7493d2'>Win+Ctrl+f</span>
      <span font="" color='#80d9d8'>aero tag:</span>               <span font="" color='#7493d2'>Win+a</span>
      <span font="" color='#80d9d8'>tag view prev:</span>          <span font="" color='#7493d2'>Win+(arrow_left)</span>
      <span font="" color='#80d9d8'>tag view next:</span>          <span font="" color='#7493d2'>Win+(arrow_right)</span>
      <span font="" color='#80d9d8'>tag history restore:</span>    <span font="" color='#7493d2'>Win+Escape</span>
            
    <span font="ohsnap 13" color='#e0da37'><b>TERMINAL:</b></span>
      <span font="" color='#eca4c4'>new terminal:</span>           <span font="" color='#e0da37'>Win+enter</span>
      <span font="" color='#eca4c4'>dropdown terminal:</span>      <span font="" color='#e0da37'>Win+z</span>
            
    <span font="ohsnap 13" color='#e33a6e'><b>WINDOW:</b></span>
      <span font="" color='#e0da37'>open window fullscreen:</span> <span font="" color='#e33a6e'>Win+f</span>
      <span font="" color='#e0da37'>maximized hor and vert:</span> <span font="" color='#e33a6e'>Win+m</span>
      <span font="" color='#e0da37'>kill window:</span>            <span font="" color='#e33a6e'>Win+Shift+c</span>
      <span font="" color='#e0da37'>floating window:</span>        <span font="" color='#e33a6e'>Win+Ctrl+space</span>
      <span font="" color='#e0da37'>move left:</span>              <span font="" color='#e33a6e'>Win+h</span> 
      <span font="" color='#e0da37'>move right:</span>             <span font="" color='#e33a6e'>Win+l</span>
      <span font="" color='#e0da37'>move up:</span>                <span font="" color='#e33a6e'>Win+k</span> 
      <span font="" color='#e0da37'>move down:</span>              <span font="" color='#e33a6e'>Win+j</span>
          
    <span font="ohsnap 13" color='#f1af5f'><b>PANEL:</b></span>
      <span font="" color='#7493d2'>hide panels:</span>            <span font="" color='#f1af5f'>Win+b</span>

    <span font="ohsnap 13" color='#80d9d8'><b>MENU:</b></span>
      <span font="" color='#e54c62'>open dynamic menu:</span>      <span font="" color='#80d9d8'>Win+w</span>

    <span font="ohsnap 13" color='#eca4c4'><b>AWESOME:</b></span>
      <span font="" color='#87af5f'>restart wm:</span>             <span font="" color='#eca4c4'>Win+Ctrl+enter</span>
      <span font="" color='#87af5f'>quit wm:</span>                <span font="" color='#eca4c4'>Win+Shift+q</span>

  <span font="ohsnap 12" color='#de5e1e'>Please click with the mouse to exit or wait 20 seconds</span>
    ]], 
    timeout = 20,
    width = 450,
    ontop = true,
    border_width = 1,
    border_color = '#535d6c' })
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
        --{{ modkey, "Shift"   }, "n"     , new_tag_with_focussed },
        {{ modkey, "Mod1"    }, "n"     , move_to_new_tag       },
        {{ modkey, "Mod1"    }, "r"     , rename_tag_to_focussed},
        {{ modkey, "Shift"   }, "r"     , rename_tag            },
        {{ modkey, "Mod1"    }, "Return", term_in_current_tag   },
        {{ modkey, "Control" }, "Return", new_tag_with_term     },
        {{ modkey, "Control" }, "f"     , fork_tag              },
        {{ modkey            }, "a"     , aero_tag              },
        {{                   }, "F1"    , hotKeys               },
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
    -- Alt + Right Shift switches the current keyboard layout
    awful.key({ alkey,            }, "Shift",  function () kbdcfg.switch() end),
    awful.key({ modkey,           }, "n",      function ()
      awful.client.focus.byidx( 1)
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
    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
      	    awful.client.focus.history.previous()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
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
            awful.util.spawn_with_shell("mpc toggle || ncmpcpp toggle || ncmpc toggle || pms toggle")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.util.spawn_with_shell("mpc stop || ncmpcpp stop || ncmpc stop || pms stop")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.util.spawn_with_shell("mpc prev || ncmpcpp prev || ncmpc prev || pms prev")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.util.spawn_with_shell("mpc next || ncmpcpp next || ncmpc next || pms next")
            mpdwidget.update()
        end),


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    -- Layout manipulation
    --awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    --awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
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
                  end))
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
