-- Coretemp
tempicon = _Awesome.wibox.widget.imagebox(_Awesome.beautiful.widget_temp)
tempwidget = _Awesome.lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#f1af5f", coretemp_now .. "°C "))
    end
})
