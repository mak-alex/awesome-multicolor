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
  ]]
}
local awful = require('awful')
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
local beautiful = require("beautiful")
quake = require("modules.scratchdrop")
menugen = require("modules.menugen")
tyrannical = require("modules.tyrannical")
--hotkeys = require("widgets/hotkeys")
local capi = {root=root,client=client,tag=tag,mouse=mouse}
local ipairs = ipairs
local unpack = unpack
local aw_util = require("awful.util")
local aw_tag = require( "awful.tag")
local aw_client = require("awful.client")
local aw_layout = require("awful.layout")
local aw_key = require("awful.key")
local aw_prompt = require("awful.prompt")
local glib = require("lgi").GLib
local shorter = require'modules.shorter'

quake_console = quake({
    terminal = userConfig.terminal.command,
    --argname = "-name %s -e tmux",
    name = "tilda",
    height = 300,
    width = 520,
    horiz = "right",
    vert = "bottom",
    screen = 1
})

-- Delete a tag as of 3.5.5, this have a few issue. Patches are on their way
local function delete_tag()
  aw_tag.delete(capi.client.focus and aw_tag.selected(capi.client.focus.screen) or aw_tag.selected(capi.mouse.screen))
end

-- Create a new tag at the end of the list
local function new_tag()
  aw_tag.viewonly(
    aw_tag.add(
      "NewTag",
      {
        screen = (capi.client.focus and capi.client.focus.screen or capi.mouse.screen)
      }
    )
  )
end

local function new_tag_with_focussed()
  local c = capi.client.focus
  local t = aw_tag.add(
    c.class,
    {
      screen = (capi.client.focus and capi.client.focus.screen or capi.mouse.screen),
      layout = aw_layout.suit.tile
    }
  )

  if c
  then
    c:tags(
      aw_util.table.join(
        c:tags(),
        {t}
      )
    )
  end

  aw_tag.viewonly(t)
end

local function move_to_new_tag()
  local c = capi.client.focus
  local t = aw_tag.add(
    c.class,
    {
      screen = (capi.client.focus and capi.client.focus.screen or capi.mouse.screen)
    }
  )

  if c
  then
    c:tags(
      {t}
    )
    aw_tag.viewonly(t)
  end
end

local function rename_tag_to_focussed()
  if capi.client.focus
  then
    local t = aw_tag.selected(capi.client.focus.screen)
    t.name = capi.client.focus.class
  end
end

local function rename_tag()
  aw_prompt.run(
    {
      prompt = "New tag name: "
    },
    mypromptbox[capi.mouse.screen].widget,
    function(new_name)
      if not new_name or #new_name == 0
      then
        return
      else
        local screen = capi.mouse.screen
        local t = aw_tag.selected(screen)

        if t
        then
          t.name = new_name
        end
      end
    end
  )
end

local function term_in_current_tag()
  aw_util.spawn(
    userConfig.terminal.command,
    {
      intrusive=true,
      slave=true
    }
  )
end

local function new_tag_with_term()
  aw_util.spawn(
    userConfig.terminal.command,
    {
      new_tag={
        volatile = true
      }
    }
  )
end

local function fork_tag()
  local s = capi.client.focus and capi.client.focus.screen or capi.mouse.screen
  local t = aw_tag.selected(s)

  if not t
  then
    return
  end

  local clients = t:clients()
  local t2 = aw_tag.add(t.name,aw_tag.getdata(t))
  t2:clients(clients)
  aw_tag.viewonly(t2)
end

local function aero_tag()
  local c = capi.client.focus

  if not c
  then
    return
  end

  local c2 = aw_client.data.focus[2]

  if (not c2) or c2 == c
  then
    return
  end

  local t = aw_tag.add(
    "Aero",
    {
      screen = c.screen ,layout=aw_layout.suit.tile,mwfact = 0.5
    }
  )

  t:clients(
    {
      c,
      c2
    }
  )

  aw_tag.viewonly(t)
end

shorter.Hardware = {
  {
    desc = "Show free space on the hard disk",
    key = {
      {
        userConfig.altkey,
      },
      "h"
    },
    fct = function ()
      fswidget.show(7)
    end
  },
}
-- {{{ Mouse bindings
root.buttons(
  awful.util.table.join(
	  awful.button(
	    { },
	    3,
	    function ()
	      mymainmenu:toggle()
	    end
	  ),
	  awful.button(
	    { },
	    4,
	    awful.tag.viewnext
	  ),
	  awful.button(
	    { },
	    5,
	    awful.tag.viewprev
	  )
  )
)

shorter.Navigation = {
  {
    desc = "Move to the previous focussed client",
    key = {{ userConfig.modkey, }, "j"},
    fct = function ()
        awful.client.focus.byidx( 1)
        if client.focus then client.focus:raise() end
    end
  },

  {
    desc = "Move to the next focussed client",
    key  = {{ userConfig.modkey,           }, "k"},
    fct  = function ()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end
  },

  {
    desc = "Jump to urgent clients",
    key = {
      {
        userConfig.modkey,
      },
      "u"
    },
    fct = awful.client.urgent.jumpto
  },
  {
    desc = "Go to the tag on the left",
    key = {
      {
        userConfig.modkey,
      },
      "Left"
    },
    fct = awful.tag.viewprev
  },
  {
    desc = "Go to the tag right",
    key = {
      {
        userConfig.modkey,
      },
      "Right"
    },
    fct = awful.tag.viewnext
  },
  {
    desc = "Go to last used tag",
    key = {
      {
        userConfig.modkey,
      },
      "Escape"
    },
    fct = awful.tag.history.restore
  },
  {
    desc = "Hide panels",
    key = {
      {
        userConfig.modkey,
      },
      "b"
    },
    fct = function ()
      mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
      mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end
  },
  {
    desc = "Switching between windows",
    key = {
      {
        userConfig.modkey,
      },
      "Tab"
    },
    fct = function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end
  },
  {
    desc = "Select focus by index +1",
    key = {
      {
        userConfig.altkey,
      },
      "k"
    },
    fct = function ()
      awful.client.focus.byidx( 1)
      if client.focus
      then
        client.focus:raise()
      end
    end
  },
  {
    desc = "Select focus by index -1",
    key = {
      {
        userConfig.altkey,
      },
      "j"
    },
    fct = function ()
      awful.client.focus.byidx(-1)
      if client.focus
      then
        client.focus:raise()
      end
    end
  },
  {
    desc = "Select focus by direction down",
    key = {
      {
        userConfig.modkey,
      },
      "j"
    },
    fct = function ()
      awful.client.focus.bydirection("down")
      if client.focus
      then
        client.focus:raise()
      end
    end
  },
  {
    desc = "Select focus by direction up",
    key = {
      {
        userConfig.modkey,
      },
      "k"
    },
    fct = function ()
      awful.client.focus.bydirection("up")
      if client.focus
      then
        client.focus:raise()
      end
    end
  },
  {
    desc = "Select focus by direction left",
    key = {
      {
        userConfig.modkey,
      },
      "h"
    },
    fct = function ()
      awful.client.focus.bydirection("left")
      if client.focus
      then
        client.focus:raise()
      end
    end
  },
  {
    desc = "Select focus by direction right",
    key = {
      {
        userConfig.modkey,
      },
      "l"
    },
    fct = function ()
      awful.client.focus.bydirection("right")
      if client.focus
      then
        client.focus:raise()
      end
    end
  },
}

shorter.Layout = {
  {
    desc = "Select layout by index +1",
    key = {
      {
        userConfig.modkey,
      },
      "space"
    },
    fct = function ()
      awful.layout.inc(awful.layout.layouts, 1)
    end
  },
  {
    desc = "Select layout by index -1",
    key = {
      {
        userConfig.modkey,
        "Shift"
      },
      "space"
    },
    fct = function ()
      awful.layout.inc(awful.layout.layouts, -1)
    end
  },
}

shorter.Music = {
  {
    desc = "Next track",
    key = {
      {
        userConfig.altkey,
        "Control"
      },
      "Right"
    },
    fct = function ()
      awful.util.spawn_with_shell(
        "mpc next || ncmpcpp next || ncmpc next || pms next"
      )
    end
  },
  {
    desc = "Previous track",
    key = {
      {
        userConfig.altkey,
        "Control"
      },
      "Left"
    },
    fct = function ()
      awful.util.spawn_with_shell(
        "mpc prev || ncmpcpp prev || ncmpc prev || pms prev"
      )
    end
  },
  {
    desc = "Play/Pause playback",
    key = {
      {
        userConfig.altkey,
        "Control"
      },
      "Up"
    },
    fct = function ()
      awful.util.spawn_with_shell(
        "mpc toggle || ncmpcpp toggle || ncmpc toggle || pms toggle"
      )
    end
  },
  {
    desc = "Stop playing",
    key = {
      {
        userConfig.altkey,
        "Control"
      },
      "Down"
    },
    fct = function ()
      awful.util.spawn_with_shell(
        "mpc stop || ncmpcpp stop || ncmpc stop || pms stop"
      )
    end
  },
  {
    desc = "Turn up the volume",
    key = {
      {
        userConfig.altkey,
      },
      "Up"
    },
    fct = function ()
      awful.util.spawn("amixer -q set Master 1%+")
    end
  },
  {
    desc = "To turn down the volume",
    key = {
      {
        userConfig.altkey,
      },
      "Down"
    },
    fct = function ()
      awful.util.spawn("amixer -q set Master 1%-")
    end
  },
  {
    desc = "To turn off the sound",
    key = {
      {
        userConfig.altkey,
      },
      "m"
    },
    fct = function ()
      awful.util.spawn("amixer -q set Master playback toggle")
    end
  },
  {
    desc = "Turn up the volume to 100%",
    key = {
      {
        userConfig.altkey,
        "Control"
      },
      "m"
    },
    fct = function ()
      awful.util.spawn("amixer -q set Master playback toggle")
    end
  },
}

shorter.Launch = {
  {
    desc = "Show this help",
    key = {
      {
        userConfig.modkey,
      }, "F1"
    },
    fct = function ()
      local real = shorter.__real
      capi.root.keys(real)
      show()
    end
  },
  {
    desc = "Launch a terminal",
    key = {
      {
        userConfig.modkey,
      }, userConfig.terminal.hotkey
    },
    fct = function ()
      awful.util.spawn(userConfig.terminal.command)                   end
  },

  {
    desc = "Drop-down terminal",
    key = {
      {
        userConfig.modkey,
      },
      "z"
    },
    fct = function ()
      quake_console:toggle()
    end
  },
  {
    desc = "Launch FileManager",
    key = {
      {
        userConfig.modkey,
        "Shift"
      },
      userConfig.terminal.hotkey
    },
    fct = function ()
      awful.util.spawn(
        userConfig.filemanager.command,
        {
          new_tag = {
            name = "files",
            exclusive = true,
            layout = awful.layout.suit.max,
            intrusive=true,
            floating=true,
            ontop = true
          }
        }
      )
    end
  },

  {
    desc = "Simple calculator",
    key = {
      {
        userConfig.modkey,
      },
      "F11"
    },
    fct = function ()
      awful.prompt.run({ prompt = '<span weight="bold"> | Calculate: </span>' }, mypromptbox[mouse.screen].widget,
        function (expr)
          if expr ~= nil and expr ~= ''
          then
            local result = awful.util.eval("return (" .. expr .. ")")
            naughty.notify(
              {
                text = expr .. " = " .. result,
                timeout = 10,
                border_width = 3,
                border_color = "#7788af",
              }
            )
          end
        end
      )
    end
  },

  {
    desc = "To make a screenshot (scrot)",
    key = {
      {
        userConfig.modkey,
        "Control"
      },
      "F12"
    },
    fct = function ()
      awful.util.spawn(
        "scrot -e 'mv $f ~/Pictures/shots/'",
        false
      )
    end
  },

  {
    desc = "An internet search (duckduckgo)",
    key = {
      {
        userConfig.altkey,
      },
      "F12"
    },
    fct = function ()
      awful.prompt.run(
        {
          prompt = '<span weight="bold"> | Web search: </span>'
        },
        mypromptbox[mouse.screen].widget,
        function (command)
          if command ~= nil and command ~= ''
          then
            awful.util.spawn(
              userConfig.browser.command
                .." 'https://duckduckgo.com/?q="
                ..command
                .."'",
              false
            )
            -- Switch to the web tag, where Firefox is, in this case tag 3
            if tags[mouse.screen][3]
            then
              awful.tag.viewonly(tags[mouse.screen][3])
            end
          end
        end
      )
    end
  },
  {
    desc = "Launch Im Client",
    key = {
      {
        userConfig.modkey,
        "Shift"
      },
      userConfig.imclient.hotkey
    },
    fct = function ()
      awful.util.spawn(
        userConfig.imclient.command,
        {
          new_tag = {
            name = "im",
            exclusive = true,
            layout = awful.layout.suit.max,
            intrusive=true,
            floating=true,
            ontop=true
          }
        }
      )
    end
  },

  {
    desc = "Launch E-mail client",
    key = {
      {
        userConfig.modkey,
        "Shift"
      },
      userConfig.email.hotkey
    },
    fct = function ()
      awful.util.spawn(
        userConfig.email.command,
        {
          new_tag = {
            name = "mail",
            exclusive = true,
            layout = awful.layout.suit.tile.top,
            intrusive = true,
            floating = true,
            ontop = true
          }
        }
      )
    end
  },

  {
    desc = "Launch Editor",
    key = {
      {
        userConfig.modkey,
        "Control"
      },
      userConfig.editor.hotkey
    },
    fct = function ()
      awful.util.spawn(userConfig.editor.command)
    end
  },

  {
    desc = "Launch Browser",
    key = {
      {
        userConfig.modkey,
        "Control"
      },
      userConfig.browser.hotkey
    },
    fct = function ()
      awful.util.spawn(
        userConfig.browser.command
          .. ' https://duckduckgo.com'
      )
    end
  },

  {
    desc = "Show the application menu",
    key = {
      {
        userConfig.modkey
      },
      "w"
    },
    fct = function()
      mymainmenu:show({
        keygrabber = true
      })
    end
  },

  {
    desc = "Run a command",
    key = {
      {
        userConfig.modkey
      },
      "r"
    },
    fct = function ()
      awful.prompt.run(
        {
          prompt = "Run: ",
          hooks = hooks
        },
        mypromptbox[mouse.screen].widget,
        function (com)
          local result = awful.util.spawn(com)
          if type(result) == "string"
          then
            mypromptbox[mouse.screen].widget:set_text(result)
          end
          return true
        end,
        awful.completion.shell,
        awful.util.getdir("cache") .. "/history"
      )
    end
  },

  {
    desc = "Run Lua Code",
    key = {
      {
        userConfig.modkey
      },
      "x"
    },
    fct = function ()
      awful.prompt.run(
        {
          prompt = "Run Lua code: "
        },
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval"
      )
    end
  }
}

shorter.Display = {
  {
    desc = "To increase the brightness",
    key = {
      {
        userConfig.modkey
      },
      "Up"
    },
    fct = function ()
      awful.util.spawn("xbacklight -inc 10%")
    end
  },
  {
    desc = "To lower the brightness",
    key = {
      {
        userConfig.modkey
      },
      "Down"
    },
    fct = function ()
      awful.util.spawn("xbacklight -dec 10%")
    end
  },
  {
    desc = "Lowering the brightness to 100%",
    key = {
      {
        userConfig.modkey,
        "Control"
      },
      "Down"
    },
    fct = function ()
      awful.util.spawn("xbacklight -dec 100%")
    end
  },
  {
    desc = "To increase the brightness to 100%",
    key = {
      {
        userConfig.modkey,
        "Control"
      },
      "Up"
    },
    fct = function ()
      awful.util.spawn("xbacklight -inc 100%")
    end
  },
}

shorter.Tag = {
  {
    desc = "Create new tag",
    key = {
      {
        userConfig.modkey,
      },
      "n"
    },
    fct = function ()
      new_tag()
    end
  },
  {
    desc = "Delete selected tag",
    key = {
      {
        userConfig.modkey,
      },
      "d"
    },
    fct = function ()
      delete_tag()
    end
  },
  {
    desc = "Rename selected tag",
    key = {
      {
        userConfig.modkey,
        "Shift"
      },
      "e"
    },
    fct = function ()
      rename_tag()
    end
  },
  {
    desc = "To rename the tag name of the open application",
    key = {
      {
        userConfig.modkey,
        userConfig.altkey,
      },
      "r"
    },
    fct = function ()
      rename_tag()
    end
  },
  {
    desc = "Create aero tag",
    key = {
      {
        userConfig.modkey,
      },
      "a"
    },
    fct = function ()
      aero_tag()
    end
  },
  {
    desc = "Fork tag",
    key = {
      {
        userConfig.modkey,
        "Control"
      },
      "f"
    },
    fct = function ()
      fork_tag()
    end
  },

  {
    desc = "To rename the tag name of the open application",
    key = {
      {
        userConfig.modkey,
        userConfig.altkey
      },
      "r"
    },
    fct = function ()
      rename_tag_to_focussed()
    end
  },
  {
    desc = "To open terminal in current tag",
    key = {
      {
        userConfig.modkey,
        userConfig.altkey
      },
      "Return"
    },
    fct = function ()
      term_in_current_tag()
    end
  },
  {
    desc = "Add a tag and open it in a terminal",
    key = {
      {
        userConfig.modkey,
        "Control"
      },
      "Return"
    },
    fct = function ()
      new_tag_with_term()
    end
  },
  {
    desc = "Add a tag and transfer the selected application",
    key = {
      {
        userConfig.modkey,
        "Shift"
      },
      "n"
    },
    fct = function ()
      new_tag_with_focussed()
    end
  },
}

shorter.Session = {
  {
    desc = "Restart Awesome",
    key = {
      {
        userConfig.modkey,
        "Control"
      },
      "r"
    },
    fct = awesome.restart
  },

  {
    desc = "Quit Awesome",
    key = {
      {
        userConfig.modkey,
        "Shift"
      },
      "q"
    },
    fct = awesome.quit
  },
}
-- {{{ Key bindings
local globalkeys = awful.util.table.join(
  globalkeys,
  awful.key(
    {
      userConfig.modkey,
      "Shift"
    },
    "h",
    function ()
      awful.tag.incnmaster( 1)
    end
  ),
  awful.key(
    {
      userConfig.modkey,
      "Shift"
    },
    "l",
    function ()
      awful.tag.incnmaster(-1)
    end
  ),
  awful.key(
    {
      userConfig.modkey,
      "Control"
    },
    "h",
    function ()
      awful.tag.incncol( 1)
    end
  ),
  awful.key(
    {
      userConfig.modkey,
      "Control"
    },
    "l",
    function ()
      awful.tag.incncol(-1)
    end
  ),
  awful.key(
    {
      userConfig.modkey,
      "Control"
    },
    "n",
    awful.client.restore
  )
) --end globalkeys

local clientkeys = awful.util.table.join(
  clientkeys,
  awful.key(
    {
      userConfig.modkey,
    },
    "f",
    function (c)
      c.fullscreen = not c.fullscreen
    end
  ),
  awful.key(
    {
      userConfig.modkey,
      "Shift"
    },
    "c",
    function (c)
      c:kill()
    end
  ),
  awful.key(
    {
      userConfig.modkey,
      "Control"
    },
    "space",
    awful.client.floating.toggle
  ),
  awful.key(
    {
      userConfig.modkey,
      "Control"
    },
    "Return",
    function (c)
      c:swap(awful.client.getmaster())
    end
  ),
  awful.key(
    {
      userConfig.modkey,
      "Shift"
    },
    "o",
    awful.client.movetoscreen
  ),
  awful.key(
    {
      userConfig.modkey,
    },
    "t",
    function (c)
      c.ontop = not c.ontop
    end
  ),
  awful.key(
    {
      userConfig.modkey,
    },
    "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
    end
  )
)

local clientbuttons = awful.util.table.join(
  clientbuttons,
  awful.button(
    { },
    1,
    function (c)
      client.focus = c; c:raise()
    end
  ),
  awful.button(
    {
      userConfig.modkey
    },
    1,
    awful.mouse.client.move
  ),
  awful.button(
    {
      userConfig.modkey
    },
    3,
    awful.mouse.client.resize
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local tagSelect = {}
for i = 1, 10 do
    tagSelect[#tagSelect+1] = {key={{ userConfig.modkey }, i},
        desc= "Switch to tag "..i,
        fct = function ()
            local screen = mouse.screen
            local tag = awful.tag.gettags(screen)[i]
            if tag then
                awful.tag.viewonly(tag)
            end
        end
    }
    tagSelect[#tagSelect+1] = {key={{ userConfig.modkey, "Control" }, i },
        desc= "Toggle tag "..i,
        fct = function ()
            local screen = mouse.screen
            local tag = awful.tag.gettags(screen)[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end
    }
    tagSelect[#tagSelect+1] = {key={{ userConfig.modkey, "Shift" }, i },
        desc= "Move cofussed to tag "..i,
        fct = function ()
            local tag = awful.tag.gettags(client.focus.screen)[i]
            if client.focus and tag then
                awful.client.movetotag(tag)
            end
        end
    }
    tagSelect[#tagSelect+1] = {key={{ userConfig.modkey, "Control", "Shift" }, i },
        desc= "Toggle tag "..i,
        fct = function ()
            local tag = awful.tag.gettags(client.focus.screen)[i]
            if client.focus and tag then
                awful.client.toggletag(tag)
            end
        end
    }
end
shorter.Navigation = tagSelect

-- Register keys
root.keys(globalkeys)

-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientkeys,
      buttons = clientbuttons
    }
  },
}

--glib.idle_add(glib.PRIORITY_DEFAULT_IDLE, register_keys)
