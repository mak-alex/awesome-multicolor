-- Weather
weathericon = wibox.widget.imagebox(beautiful.widget_weather)
yawn = lain.widgets.yawn(1234567, {
    settings = function()
        widget:set_markup(markup("#eca4c4", forecast:lower() .. " @ " .. units .. "°C "))
    end
})