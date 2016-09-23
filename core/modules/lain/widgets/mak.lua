local newtimer        = require("modules.lain.helpers").newtimer
local wibox           = require("wibox")

local io              = { lines  = io.lines }
local math            = { floor  = math.floor }
local string          = { format = string.format,
                          gmatch = string.gmatch,
                          len    = string.len }

local setmetatable    = setmetatable
-- Memory usage (ignoring caches)
-- lain.widgets.mak
local mak = {}
local notification  = nil
mak_notification_preset = { fg = beautiful.fg_normal }

function mak:hide()
    if notification ~= nil then
        naughty.destroy(notification)
        notification = nil
    end
end

function mak:show(t_out)
    mak:hide()
    ws = [[
_NAME CONFIG   'FH-MultiColor'
_VERSION       'MULTICOLOR v0.1.0-rc1'
_URL           'https://bitbucket.org/enlab/multicolor'
_MAIL          'flashhacker1988@gmail.com'
_AUTHOR        'Alex M.A.K.'

## Multicolor Configuration for the awesome window manager (3.5)
* If you're disappointed by fonts, check your `~/.fonts.conf`. 
* It is presumed that you configure your autostart in `~/.xinitrc`.
* Help with hotkeys <F1>

## What do we have?
* Dynamic tags
* Terms tags for dynamic tags
* The drop-down terminal
* Running the backup configuration
* Widgets
* Generated applications menu
* Dynamic desktop background
* And many other amenities ...
 
## Capabilities
* Themes
* Dynamic wallpaper
* Test script for hacking
* Dynamic desktop tagging (via tyrannical)
* ALSA control (by Rman)
* Freedesktop menu
* Multiple desktop support
* Beautiful notifications (via naughty)

## Dependencies
* beautiful
* vicious
* naughty
* tyrannical (optional)
* Dynamic generate menu (via Alex M.A.K)
* Dropdown terminal (via Alex M.A.K)
    ]]

    notification = naughty.notify({
        preset = mak_notification_preset,
        text = ws,
        timeout = t_out,
        border_width = 3,
        border_color = "#7788af"
    })
end

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 3
    local settings = args.settings or function() end

    mak.widget = wibox.widget.textbox(' ')

    function update()
        mak_now = {}
        mak_now.title = '<span font="Hack 14"><b>M.A.K.</b></span>'
        widget = mak.widget
        settings()
    end
    newtimer("mak", timeout, update)

    widget:connect_signal('mouse::enter', function () mak:show(0) end)
    widget:connect_signal('mouse::leave', function () mak:hide() end)

    return mak.widget
end

return setmetatable(mak, { __call = function(_, ...) return worker(...) end })
