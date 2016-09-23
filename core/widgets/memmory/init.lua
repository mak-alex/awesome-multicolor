-- MEM
memicon = _Awesome.wibox.widget.imagebox(_Awesome.beautiful.widget_mem)
memwidget = _Awesome.lain.widgets.mem({
    settings = function()
	widget:set_markup(markup("#e0da37", mem_now.used .. "M "))
    end
})
