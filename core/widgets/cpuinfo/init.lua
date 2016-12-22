markup = _Awesome.lain.util.markup
cpuicon = _Awesome.wibox.widget.imagebox()
cpuicon:set_image(_Awesome.beautiful.widget_cpu)
cpuwidget = _Awesome.lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
    end
})
