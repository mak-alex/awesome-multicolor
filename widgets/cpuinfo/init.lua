local vicious           = require("modules.vicious")
-- | Markup | --
markup = lain.util.markup

space3 = markup.font("Hack 3", " ")
space2 = markup.font("Hack 2", " ")
vspace1 = '<span font="Hack 3"> </span>'
vspace2 = '<span font="Hack 3">  </span>'
clockgf = beautiful.clockgf

-- CPU
if themename ~= "pro-dark" and themename ~= "pro-gotham" and themename ~= "pro-light" and themename ~= "pro-medium-dark" and themename ~= "pro-medium-light"
then
	cpuicon = wibox.widget.imagebox()
	cpuicon:set_image(beautiful.widget_cpu)
	cpuwidget = lain.widgets.cpu({
	    settings = function()
	        widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
	    end
	})
else
	  -- | CPU / TMP | --
	cpu_widget = lain.widgets.cpu({
	    settings = function()
	        widget:set_markup(space3 .. cpu_now.usage .. "%" .. markup.font("Tamsyn 4", " "))
	    end
	})
	widget_cpu = wibox.widget.imagebox()
	widget_cpu:set_image(beautiful.widget_cpu)
	cpuwidget = wibox.widget.background()
	cpuwidget:set_widget(cpu_widget)
	cpuwidget:set_bgimage(beautiful.widget_display)
end

tmp_widget = wibox.widget.textbox()
vicious.register(tmp_widget, vicious.widgets.thermal, vspace1 .. "$1°C" .. vspace1, 9, "thermal_zone0")

widget_tmp = wibox.widget.imagebox()
widget_tmp:set_image(beautiful.widget_tmp)
tmpwidget = wibox.widget.background()
tmpwidget:set_widget(tmp_widget)
tmpwidget:set_bgimage(beautiful.widget_display)
