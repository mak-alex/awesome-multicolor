-- Textclock
markup = lain.util.markup
blue = "#80CCE6"
space3 = markup.font("Terminus 10px", " ")
space2 = markup.font("Terminus 10px", " ")
-- Clock
mytextclock = awful.widget.textclock(markup("#de5e1e", space3 .. "%H:%M" .. space2))
clock_icon = wibox.widget.imagebox()
clock_icon:set_image(beautiful.clock)
clockwidget = wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(beautiful.widget_bg)
-- Calendar
mytextcalendar = awful.widget.textclock(markup("#7788af", space2 .. "%A %d %b<span font='Terminus 10px'> </span>"..markup("#343639", ">")))
calendar_icon = wibox.widget.imagebox()
calendar_icon:set_image(beautiful.calendar)
calendarwidget = wibox.widget.background()
calendarwidget:set_widget(mytextcalendar)
calendarwidget:set_bgimage(beautiful.widget_bg)
lain.widgets.calendar:attach(calendarwidget, { fg = "#7788af", position = "top_right" })