-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    battery="BAT1",
    settings = function()
        if bat_now.perc == "N/A" then
            bat_now.perc = "AC "
        else
            bat_now.perc = bat_now.perc .. "% "
        end
        widget:set_text(bat_now.perc)
    end
})
