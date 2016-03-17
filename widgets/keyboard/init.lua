local wibox = require("wibox")
local awful = require("awful")
if themename ~= "pro-dark" and themename ~= "pro-gotham" and themename ~= "pro-light" and themename ~= "pro-medium-dark" and themename ~= "pro-medium-light"
then
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
else
	kbdcfg = {}
	kbdcfg.cmd = "setxkbmap"
	kbdcfg.layout = { { "us", "" , "en" }, { "ru", "" , "ru" } }
	kbdcfg.current = 1  -- us is our default layout
	--[[kbdcfg.widget = wibox.widget.imagebox()
	kbdcfg.widget:set_image(theme.english)
	kbdcfg.widget:set_bgimage(beautiful.widget_display)]]

	kbdcfg.widget = wibox.widget.imagebox()
	kbdcfg.widget:set_image(theme.english)
	kbdcfg_widget = wibox.widget.background()
	kbdcfg_widget:set_widget(kbdcfg.widget)
	kbdcfg_widget:set_bgimage(theme.widget_display)

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
end

return kbdcfg