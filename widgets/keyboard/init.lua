local wibox = require("wibox")
local awful = require("awful")
-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "us", "" , "en" }, { "ru", "" , "ru" } }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = wibox.widget.imagebox()
kbdcfg.widget:set_image(theme.english)
kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    if t[3] == "en" then
        kbdcfg.widget:set_image(theme.english)
    else
        kbdcfg.widget:set_image(theme.russian)
    end
    os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end
kbdcfg.widget:buttons(
    awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)

return kbdcfg