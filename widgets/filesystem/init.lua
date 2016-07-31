-- | Markup | --
vspace1 = '<span font="Hack 3"> </span>'
vspace2 = '<span font="Hack 3">  </span>'

if not string.find(themename, "pro-")
then
	-- / fs
	fsicon = wibox.widget.imagebox(beautiful.widget_fs)
	fswidget = lain.widgets.fs({
      partition = "/home",
	    settings  = function()
	        widget:set_markup(markup("#80d9d8", fs_now.available .. "% "))
	    end
	})
else
	 -- | FS | --
	fs_widget = wibox.widget.textbox()
	vicious.register(fs_widget, vicious.widgets.fs, vspace1 .. "${/ avail_gb}GB" .. vspace1, 2)
	widget_fs = wibox.widget.imagebox()
	widget_fs:set_image(beautiful.widget_fs)
	fswidget = wibox.widget.background()
	fswidget:set_widget(fs_widget)
	fswidget:set_bgimage(beautiful.widget_display)
end
