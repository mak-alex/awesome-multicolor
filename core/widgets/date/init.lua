-- {{{ Markup
local markup = _Awesome.lain.util.markup
local clockgf = _Awesome.beautiful.clockgf
local space3 = markup.font("Hack 3", " ")
local space2 = markup.font("Hack 2", " ")
-- }}}

-- {{{ Clock / Calendar
mytextclock = _Awesome.awful.widget.textclock(markup("#de5e1e", space3 .. "%D %H:%M" .. space2))
widget_clock = _Awesome.wibox.widget.imagebox()
widget_clock:set_image(_Awesome.beautiful.widget_clock)
-- }}}

-- {{{ Calendar
mytextcalendar = _Awesome.awful.widget.textclock(markup("#7788af", space2 .. "%A %d %B<span font='Terminus 10px'> </span>"..markup("#343639", "")))

clockwidget = _Awesome.wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(_Awesome.beautiful.widget_display)
-- }}}

local index = 1
local loop_widgets = {
  mytextclock,
  mytextcalendar
}
local loop_widgets_icons = {
  _Awesome.beautiful.widget_clock,
  _Awesome.beautiful.widget_cal
}

clockwidget:buttons(
  _Awesome.awful.util.table.join(
    _Awesome.awful.button(
      {},
      1,
      function ()
        index = index % #loop_widgets + 1
        clockwidget:set_widget(loop_widgets[index])
        widget_clock:set_image(loop_widgets_icons[index])
      end
    )
  )
)

return widget_clock, clockwidget
