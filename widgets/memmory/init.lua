if themename ~= "pro-dark" and themename ~= "pro-gotham" and themename ~= "pro-light" and themename ~= "pro-medium-dark" and themename ~= "pro-medium-light"
then
	-- MEM
	memicon = wibox.widget.imagebox(beautiful.widget_mem)
	memwidget = lain.widgets.mem({
	    settings = function()
	        widget:set_markup(markup("#e0da37", mem_now.used .. "M "))
	    end
	})
else
	  -- | MEM | --
	mem_widget = lain.widgets.mem({
	    settings = function()
	      if mem_now.used>1024 then
	        widget:set_markup(space3 .. math.floor(mem_now.used/1024) .. "GB" .. markup.font("Tamsyn 4", " "))
	      else
	        widget:set_markup(space3 .. mem_now.used .. "MB" .. markup.font("Tamsyn 4", " "))
	      end
	    end
	})

	widget_mem = wibox.widget.imagebox()
	widget_mem:set_image(beautiful.widget_mem)
	memwidget = wibox.widget.background()
	memwidget:set_widget(mem_widget)
	memwidget:set_bgimage(beautiful.widget_display)
end