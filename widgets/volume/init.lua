-- ALSA volume
if themename ~= "pro-dark" and themename ~= "pro-gotham" and themename ~= "pro-light" and themename ~= "pro-medium-dark" and themename ~= "pro-medium-light"
then
	volumewidget = lain.widgets.alsa({
	    settings = function()
	        if volume_now.status == "off" then
	            volume_now.level = volume_now.level .. "M"
	        end

	        widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
	    end
	})
else
	  -- | ALSA volume | --
	widget_vol = lain.widgets.alsa({
	    settings = function()
	        if volume_now.status == "off" then
	            volume_now.level = volume_now.level .. "M"
	        end
	        widget:set_markup(markup(clockgf, space3 .. volume_now.level .. "% "))
	    end
	})
	volumewidget = wibox.widget.background()
	volumewidget:set_widget(widget_vol)
	volumewidget:set_bgimage(beautiful.widget_display)
end