-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)

bat_widget = lain.widgets.bat({
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

batwidget = wibox.widget.background()
batwidget:set_widget(bat_widget)
batwidget:set_bgimage(beautiful.widget_display)

bat_label = wibox.widget.textbox("bat: ")
batlabel = wibox.widget.background()
batlabel:set_widget(bat_label)
batlabel:set_bg(beautiful.taglist_bg_focus)
batlabel:set_fg(beautiful.fg_focus)