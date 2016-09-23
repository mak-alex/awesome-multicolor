-- MEM
makicon = wibox.widget.imagebox(beautiful.widget_mem)
makwidget = lain.widgets.mak({
    settings = function()
        widget:set_markup(markup("#e0da37", mak_now.title))
    end
})