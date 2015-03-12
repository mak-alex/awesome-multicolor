-- MEM
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup("#e0da37", mem_now.used .. "M "))
    end
})