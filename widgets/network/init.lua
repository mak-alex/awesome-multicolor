if themename ~= "pro-dark" and themename ~= "pro-gotham" and themename ~= "pro-light" and themename ~= "pro-medium-dark" and themename ~= "pro-medium-light"
then
	-- Net
	netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
	--netdownicon.align = "middle"
	netdowninfo = wibox.widget.textbox()
	netupicon = wibox.widget.imagebox(beautiful.widget_netup)
	--netupicon.align = "middle"
	netupinfo = lain.widgets.net({
	    settings = function()
	        widget:set_markup(markup("#e54c62", net_now.sent .. " "))
	        netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
	    end
	})

	  -- | NET | --
	net_widgetdl = wibox.widget.textbox()
	net_widgetul = lain.widgets.net({
	    settings = function()
	        widget:set_markup(markup.font("Tamsyn 1", "  ") .. net_now.sent)
	        net_widgetdl:set_markup(markup.font("Tamsyn 1", " ") .. net_now.received .. markup.font("Tamsyn 1", " "))
	    end
	})

	widget_netdl = wibox.widget.imagebox()
	widget_netdl:set_image(beautiful.widget_netdl)
	netwidgetdl = wibox.widget.background()
	netwidgetdl:set_widget(net_widgetdl)
	netwidgetdl:set_bgimage(beautiful.widget_display)

	widget_netul = wibox.widget.imagebox()
	widget_netul:set_image(beautiful.widget_netul)
	netwidgetul = wibox.widget.background()
	netwidgetul:set_widget(net_widgetul)
	netwidgetul:set_bgimage(beautiful.widget_display)
else
	  -- | NET | --
	net_widgetdl = wibox.widget.textbox()
	net_widgetul = lain.widgets.net({
	    settings = function()
	        widget:set_markup(markup.font("Tamsyn 1", "  ") .. net_now.sent)
	        net_widgetdl:set_markup(markup.font("Tamsyn 1", " ") .. net_now.received .. markup.font("Tamsyn 1", " "))
	    end
	})

	widget_netdl = wibox.widget.imagebox()
	widget_netdl:set_image(beautiful.widget_netdl)
	netwidgetdl = wibox.widget.background()
	netwidgetdl:set_widget(net_widgetdl)
	netwidgetdl:set_bgimage(beautiful.widget_display)

	widget_netul = wibox.widget.imagebox()
	widget_netul:set_image(beautiful.widget_netul)
	netwidgetul = wibox.widget.background()
	netwidgetul:set_widget(net_widgetul)
	netwidgetul:set_bgimage(beautiful.widget_display)
end

return widget_netdl, netwidgetdl, widget_netul, netwidgetul