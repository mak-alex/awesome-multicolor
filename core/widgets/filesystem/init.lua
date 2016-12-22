-- | Markup | --
vspace1 = '<span font="Hack 3"> </span>'
vspace2 = '<span font="Hack 3">  </span>'

-- / fs
fsicon = _Awesome.wibox.widget.imagebox(_Awesome.beautiful.widget_fs)
fswidget = _Awesome.lain.widgets.fs({
    settings  = function()
        widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
    end
})
