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
mytextcalendar = awful.widget.textclock(markup("#7788af", space2 .. "%A %d %b<span font='Terminus 10px'> </span>"..markup("#343639", "")))
calendar_icon = wibox.widget.imagebox()
calendar_icon:set_image(beautiful.calendar)
calendarwidget = wibox.widget.background()
calendarwidget:set_widget(mytextcalendar)
calendarwidget:set_bgimage(beautiful.widget_bg)
lain.widgets.calendar:attach(calendarwidget, { fg = "#7788af", position = "top_right" })

-- | Markup | --
local markup = lain.util.markup
local clockgf = beautiful.clockgf
local space3 = markup.font("Hack 3", " ")
local space2 = markup.font("Hack 2", " ")
  -- | Clock / Calendar | --
mytextclock    = awful.widget.textclock(markup(clockgf, space3 .. "%H:%M" .. markup.font("Tamsyn 3", " ")))
mytextcalendar = awful.widget.textclock(markup(clockgf, space3 .. "%a %d %b"))

widget_clock = wibox.widget.imagebox()
widget_clock:set_image(beautiful.widget_clock)

clockwidget = wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(beautiful.widget_display)

local index = 1
local loop_widgets = { mytextclock, mytextcalendar }
local loop_widgets_icons = { beautiful.widget_clock, beautiful.widget_cal }

clockwidget:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        index = index % #loop_widgets + 1
        clockwidget:set_widget(loop_widgets[index])
        widget_clock:set_image(loop_widgets_icons[index])
    end)))

return widget_clock, clockwidget