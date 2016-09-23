-- Battery
baticon = _Awesome.wibox.widget.imagebox(_Awesome.beautiful.widget_batt)

bat_widget = _Awesome.lain.widgets.bat({
    battery="BAT1",
    settings = function()
      if bat_now.perc ~= "N/A" then
          bat_now.perc = bat_now.perc .. "% "
          widget:set_text(bat_now.perc)
      else
        widget:set_text("AC")
      end
    end
})

batwidget = _Awesome.wibox.widget.background()
batwidget:set_widget(bat_widget)
batwidget:set_bgimage(_Awesome.beautiful.widget_display)

bat_label = _Awesome.wibox.widget.textbox("bat: ")
batlabel = _Awesome.wibox.widget.background()
batlabel:set_widget(bat_label)
batlabel:set_bg(_Awesome.beautiful.taglist_bg_focus)
batlabel:set_fg(_Awesome.beautiful.fg_focus)
