local SCRATCHDROP = {
  _NAME = "Scratchdrop",
  _VERSION = 'Scratchdrop v0.1.0-rc1',
  _URL = 'https://bitbucket.org/enlab/scratchdrop',
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
    Drop-down applications manager for the awesome window manager
      To use this module add:
        local scratchdrop = require("scratchdrop")
        to the top of your rc.lua, and call it from a keybinding:
        scratchdrop(prog, vert, horiz, width, height, sticky, screen)
      Parameters:
        prog   - Program to run; "urxvt", "gmrun", "thunderbird"
        vert   - Vertical; "bottom", "center" or "top" (default)
        horiz  - Horizontal; "left", "right" or "center" (default)
        width  - Width in absolute pixels, or width percentage
                when <= 1 (1 (100% of the screen) by default)
        height - Height in absolute pixels, or height percentage
                when <= 1 (0.25 (25% of the screen) by default)
        sticky - Visible on all tags, false by default
        screen - Screen (optional), mouse.screen by default
    ]]
}
-- Grab environment
local pairs = pairs
local awful = require("awful")
local setmetatable = setmetatable
local capi = { mouse = mouse, client = client, screen = screen }

-- Scratchdrop: drop-down applications manager for the awesome window manager
local scratchdrop = {} -- module scratch.drop
local dropdown = {}

-- Create a new window for the drop-down application when it doesn't
-- exist, or toggle between hidden and visible states when it does
function toggle(prog, vert, horiz, width, height, sticky, screen)
    vert   = vert   or "top"
    horiz  = horiz  or "center"
    width  = width  or 1
    height = height or 0.25
    sticky = sticky or false
    screen = screen or capi.mouse.screen

    -- Determine signal usage in this version of awesome
    local attach_signal = capi.client.connect_signal    or capi.client.add_signal
    local detach_signal = capi.client.disconnect_signal or capi.client.remove_signal

    if not dropdown[prog] then
        dropdown[prog] = {}

        -- Add unmanage signal for scratchdrop programs
        attach_signal("unmanage", function (c)
            for scr, cl in pairs(dropdown[prog]) do
                if cl == c then
                    dropdown[prog][scr] = nil
                end
            end
        end)
    end

    if not dropdown[prog][screen] then
        spawnw = function (c)
            dropdown[prog][screen] = c

            -- Scratchdrop clients are floaters
            awful.client.floating.set(c, true)

            -- Client geometry and placement
            local screengeom = capi.screen[screen].workarea

            if width  <= 1 then width  = screengeom.width  * width  end
            if height <= 1 then height = screengeom.height * height end

            if     horiz == "left"  then x = screengeom.x
            elseif horiz == "right" then x = screengeom.width - width
            else   x =  screengeom.x+(screengeom.width-width)/2 end

            if     vert == "bottom" then y = screengeom.height + screengeom.y - height
            elseif vert == "center" then y = screengeom.y+(screengeom.height-height)/2
            else   y =  screengeom.y - screengeom.y end

            -- Client properties
            c:geometry({ x = x, y = y + widgetbox[mouse.screen].height, width = width - 2, height = height })
            c.ontop = true
            c.above = true
            c.skip_taskbar = true
            if sticky then c.sticky = true end
            if c.titlebar then awful.titlebar.remove(c) end

            c:raise()
            capi.client.focus = c
            detach_signal("manage", spawnw)
        end

        -- Add manage signal and spawn the program
        attach_signal("manage", spawnw)
        awful.util.spawn(prog, false)
    else
        -- Get a running client
        c = dropdown[prog][screen]

        -- Switch the client to the current workspace
        if c:isvisible() == false then c.hidden = true
            awful.client.movetotag(awful.tag.selected(screen), c)
        end

        -- Focus and raise if hidden
        if c.hidden then
            -- Make sure it is centered
            --if vert  == "center" then awful.placement.center_vertical(c)   end
            --if horiz == "center" then awful.placement.center_horizontal(c) end
            c.hidden = false
            c:raise()
            capi.client.focus = c
        else -- Hide and detach tags if not
            c.hidden = true
            local ctags = c:tags()
            for i, t in pairs(ctags) do
                ctags[i] = nil
            end
            c:tags(ctags)
        end
    end
end

return setmetatable(scratchdrop, { __call = function(_, ...) return toggle(...) end })
