-- Textclock
markup      = lain.util.markup
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#343639", ">") .. markup("#de5e1e", " %H:%M "))