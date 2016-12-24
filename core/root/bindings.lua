local awful = require('awful')
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
local beautiful = require("beautiful")
menugen = require("core.modules.menugen")
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
local shorter = require'core.modules.shorter'

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
    _Awesome.applications.terminal,
    {
      intrusive=true,
      slave=true
    }
  )
end

local function new_tag_with_term()
  aw_util.spawn(
    _Awesome.applications.terminal,
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
      screen = c.screen, layout = aw_layout.suit.tile, mwfact = 0.5
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
        _Awesome.altkey,
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
    key = {
      {
        _Awesome.modkey,
        "Control"
      },
      "j"
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
    desc = "Move to the next focussed client",
    key  = {
      {
        _Awesome.modkey,
        "Control"
      },
      "k"
    },
    fct  = function ()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end
  },

  {
    desc = "Jump to urgent clients",
    key = {
      {
        _Awesome.modkey,
      },
      "u"
    },
    fct = awful.client.urgent.jumpto
  },

  {
    desc = "Go to the tag on the left",
    key = {
      {
        _Awesome.modkey,
      },
      "Left"
    },
    fct = awful.tag.viewprev
  },

  {
    desc = "Go to the tag right",
    key = {
      {
        _Awesome.modkey,
      },
      "Right"
    },
    fct = awful.tag.viewnext
  },

  {
    desc = "Go to last used tag",
    key = {
      {
        _Awesome.modkey,
      },
      "Escape"
    },
    fct = awful.tag.history.restore
  },

  {
    desc = "Hide top panel",
    key = {
      {
        _Awesome.modkey,
        "Shift"
      },
      "t"
    },
    fct = function ()
      if _Awesome.switches.panels.top
      then
        _Awesome._wibox.top[mouse.screen].visible = not _Awesome._wibox.top[mouse.screen].visible
      end
    end
  },

  {
    desc = "Hide bottom panel",
    key = {
      {
        _Awesome.modkey,
        "Shift"
      },
      "b"
    },
    fct = function ()
      if _Awesome.switches.panels.bottom
      then
        _Awesome._wibox.bottom[mouse.screen].visible = not _Awesome._wibox.bottom[mouse.screen].visible
      end
    end
  },

  {
    desc = "Hide panels",
    key = {
      {
        _Awesome.modkey,
      },
      "b"
    },
    fct = function ()
      if _Awesome.switches.panels.top
      then
        _Awesome._wibox.top[mouse.screen].visible = not _Awesome._wibox.top[mouse.screen].visible
      end
      if _Awesome.switches.panels.bottom
      then
        _Awesome._wibox.bottom[mouse.screen].visible = not _Awesome._wibox.bottom[mouse.screen].visible
      end
    end
  },

  {
    desc = "Switching between windows",
    key = {
      {
        _Awesome.modkey,
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
        _Awesome.altkey,
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
        _Awesome.altkey,
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
        _Awesome.modkey,
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
        _Awesome.modkey,
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
-- By direction client focus
  {
    desc = "Select focus by direction left",
    key = {
      {
        _Awesome.modkey,
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
        _Awesome.modkey,
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
  {
    desc = "Select focus by direction down",
    key = {
      {
        _Awesome.modkey,
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
        _Awesome.modkey,
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
}

shorter.Layout = {
  {
    desc = "Select layout by index +1",
    key = {
      {
        _Awesome.modkey,
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
        _Awesome.modkey,
        "Shift"
      },
      "space"
    },
    fct = function ()
      awful.layout.inc(awful.layout.layouts, -1)
    end
  },
}

if _Awesome.switches.system.mpd
then
  shorter.MPD = {
    {
      desc = "Next track",
      key = {
        {
          _Awesome.altkey,
          "Control"
        },
        "Right"
      },
      fct = function ()
        local response = _Awesome.mpd:next()
        _Awesome.variables.mpd.status.state = response.state
        local _, track = response.file:match('(.-)/(.*)')
        _Awesome.variables.mpd.status.track = track
        _Awesome.notify.message(
          'MPD Status: ',
          '\n * Current state: ' .. response.state
            .. '\n * Current track: ' .. response.file
        )
      end
    },

    {
      desc = "Info MPD",
      key = {
        {
          _Awesome.altkey,
          "Control"
        },
        "m"
      },
      fct = function ()
        _Awesome:StatMPD()
      end
    },

    {
      desc = "Previous track",
      key = {
        {
          _Awesome.altkey,
          "Control"
        },
        "Left"
      },
      fct = function ()
        local response = _Awesome.mpd:previous()
        _Awesome.variables.mpd.status.state = response.state
        local _, _, track = response.file:match('(.-)/(.*)/(.*)')
        _Awesome.variables.mpd.status.track = track
        _Awesome.notify.message(
          'MPD Status: ',
          '\n * Current state: ' .. response.state
            .. '\n * Current track: ' .. response.file
        )
      end
    },

    {
      desc = "Play/Pause playback",
      key = {
        {
          _Awesome.altkey,
          "Control"
        },
        "Up"
      },
      fct = function ()
        local response = _Awesome.mpd:toggle_play()
        _Awesome.variables.mpd.status.state = response.state
        local _, track = response.file:match("(.-)/(.*)")
        _Awesome.variables.mpd.status.track = track
        _Awesome.notify.message(
          'MPD Status: ',
          '\n * Current state: ' .. response.state
          .. '\n * Current track: ' .. _Awesome.variables.mpd.status.track
        )
      end
    },

    {
      desc = "Stop playing",
      key = {
        {
          _Awesome.altkey,
          "Control"
        },
        "Down"
      },
      fct = function ()
        local response = _Awesome.mpd:stop()
        _Awesome.variables.mpd.status.state = response.state
        _Awesome.variables.mpd.status.track = response.file
        _Awesome.notify.message(
          'MPD Status: ',
          '\n * Current state: ' .. response.state
            .. '\n * Current track: ' .. response.file
        )
      end
    },
  }
end
shorter.Music = {
  {
    desc = "Turn up the volume",
    key = {
      {
        _Awesome.altkey,
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
        _Awesome.altkey,
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
        _Awesome.altkey,
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
        _Awesome.modkey,
	"Control"
      },
      "m"
    },
    fct = function ()
      awful.util.spawn("amixer -q set Master 100%+")
    end
  },
}

shorter.Launch = {
  {
    desc = "Show this help",
    key = {
      {
        _Awesome.modkey,
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
        _Awesome.modkey,
      },
      'Return'
    },
    fct = function ()
      awful.util.spawn(_Awesome.applications.terminal)
    end
  },

  {
    desc = "Launch FileManager",
    key = {
      {
        _Awesome.modkey,
        "Shift"
      },
      'f'
    },
    fct = function ()
      awful.util.spawn(
        _Awesome.applications.filemanager,
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
        _Awesome.modkey,
      },
      "F11"
    },
    fct = function ()
      awful.prompt.run(
        {
          prompt = '<span weight="bold"> | Calculate: </span>'
        },
        mypromptbox[mouse.screen].widget,
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
        _Awesome.modkey,
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
        _Awesome.altkey,
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
              _Awesome.applications.browser
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
        _Awesome.modkey,
        "Shift"
      },
      'i'
    },
    fct = function ()
      awful.util.spawn(
        _Awesome.applications.im,
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
        _Awesome.modkey,
        "Shift"
      },
      'm'
    },
    fct = function ()
      awful.util.spawn(
        _Awesome.applications.email,
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
        _Awesome.modkey,
        "Control"
      },
      'e'
    },
    fct = function ()
      awful.util.spawn(_Awesome.applications.editor)
    end
  },

  {
    desc = "Launch Browser",
    key = {
      {
        _Awesome.modkey,
        "Control"
      },
      'w'
    },
    fct = function ()
      awful.util.spawn(
        _Awesome.applications.browser
          .. ' https://duckduckgo.com'
      )
    end
  },

  {
    desc = "Show the application menu",
    key = {
      {
        _Awesome.modkey
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
        _Awesome.modkey
      },
      "r"
    },
    fct = function ()
      _Awesome.awful.prompt.run(
        {
          prompt = "Run: ",
          hooks = hooks
        },
        mypromptbox[mouse.screen].widget,
        function (com)
          local result = _Awesome.awful.util.spawn(com)
          if type(result) == "string"
          then
            mypromptbox[mouse.screen].widget:set_text(result)
          end
          return true
        end,
        _Awesome.awful.completion.shell,
        _Awesome.awful.util.getdir("cache") .. "/history"
      )
    end
  },

  {
    desc = "Run Lua Code",
    key = {
      {
        _Awesome.modkey
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
        _Awesome.modkey
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
        _Awesome.modkey
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
        _Awesome.modkey,
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
        _Awesome.modkey,
        "Control"
      },
      "Up"
    },
    fct = function ()
      awful.util.spawn("xbacklight -inc 100%")
    end
  },
}

if _Awesome.switches.system.dynamic_tags
then
  shorter.Tag = {
    {
      desc = "Create new tag",
      key = {
        {
          _Awesome.modkey,
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
          _Awesome.modkey,
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
          _Awesome.modkey,
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
          _Awesome.modkey,
          _Awesome.altkey,
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
          _Awesome.modkey,
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
          _Awesome.modkey,
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
          _Awesome.modkey,
          _Awesome.altkey
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
          _Awesome.modkey,
          _Awesome.altkey
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
          _Awesome.modkey,
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
          _Awesome.modkey,
          "Shift"
        },
        "n"
      },
      fct = function ()
        new_tag_with_focussed()
      end
    },
  }
end

shorter.Session = {
  {
    desc = "Restart Awesome",
    key = {
      {
        _Awesome.modkey,
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
        _Awesome.modkey,
        "Shift"
      },
      "q"
    },
    fct = awesome.quit
  },
}

local globalkeys = awful.util.table.join(
  globalkeys,
  awful.key(
    {
      _Awesome.modkey,
      "Shift"
    },
    "h",
    function ()
      awful.tag.incnmaster( 1)
    end
  ),
  awful.key(
    {
      _Awesome.modkey,
      "Shift"
    },
    "l",
    function ()
      awful.tag.incnmaster(-1)
    end
  ),
  awful.key(
    {
      _Awesome.modkey,
      "Control"
    },
    "h",
    function ()
      awful.tag.incncol( 1)
    end
  ),
  awful.key(
    {
      _Awesome.modkey,
      "Control"
    },
    "l",
    function ()
      awful.tag.incncol(-1)
    end
  ),
  awful.key(
    {
      _Awesome.modkey,
      "Control"
    },
    "n",
    awful.client.restore
  )
)

local clientkeys = awful.util.table.join(
  clientkeys,
  awful.key(
    {
      _Awesome.modkey,
    },
    "f",
    function (c)
      c.fullscreen = not c.fullscreen
    end
  ),
  awful.key(
    {
      _Awesome.modkey,
      "Shift"
    },
    "c",
    function (c)
      c:kill()
    end
  ),
  awful.key(
    {
      _Awesome.modkey,
      "Control"
    },
    "space",
    awful.client.floating.toggle
  ),
  awful.key(
    {
      _Awesome.modkey,
      "Control"
    },
    "Return",
    function (c)
      c:swap(awful.client.getmaster())
    end
  ),
  awful.key(
    {
      _Awesome.modkey,
      "Shift"
    },
    "o",
    awful.client.movetoscreen
  ),
  awful.key(
    {
      _Awesome.modkey,
    },
    "t",
    function (c)
      c.ontop = not c.ontop
    end
  ),
  awful.key(
    {
      _Awesome.modkey,
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
      _Awesome.modkey
    },
    1,
    awful.mouse.client.move
  ),
  awful.button(
    {
      _Awesome.modkey
    },
    3,
    awful.mouse.client.resize
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local tagSelect = {}
for i = 1, 10
do
  tagSelect[#tagSelect+1] = {
    key = {
      {
        _Awesome.modkey
      },
      i
    },
    desc= "Switch to tag "..i,
    fct = function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]
        if tag
        then
            awful.tag.viewonly(tag)
        end
    end
  }
  tagSelect[#tagSelect+1] = {
    key = {
      {
        _Awesome.modkey,
        "Control"
      },
      i
    },
    desc= "Toggle tag "..i,
    fct = function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]
        if tag
        then
            awful.tag.viewtoggle(tag)
        end
    end
  }
  tagSelect[#tagSelect+1] = {
    key = {
      {
        _Awesome.modkey,
        "Shift"
      },
      i
    },
    desc= "Move cofussed to tag "..i,
    fct = function ()
        local tag = awful.tag.gettags(client.focus.screen)[i]
        if client.focus and tag
        then
            awful.client.movetotag(tag)
        end
    end
  }
  tagSelect[#tagSelect+1] = {
    key = {
      {
        _Awesome.modkey,
        "Control",
        "Shift"
      },
      i
    },
    desc= "Toggle tag "..i,
    fct = function ()
        local tag = awful.tag.gettags(client.focus.screen)[i]
        if client.focus and tag
        then
            awful.client.toggletag(tag)
        end
    end
  }
end
shorter.Navigation = tagSelect

-- Register keys
root.keys(globalkeys)

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
