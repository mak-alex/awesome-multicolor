netupicon = _Awesome.wibox.widget.imagebox(_Awesome.beautiful.widget_netup)
netdownicon = _Awesome.wibox.widget.imagebox(_Awesome.beautiful.widget_netdown)

netdowninfo = _Awesome.wibox.widget.textbox()
netupinfo = _Awesome.lain.widgets.net(
  {
    settings = function()
      widget:set_markup(makrup('#e54c62', net_now.sent .. ''))
      netdowninfo:set_markup(makrup('#87af5f', net_now.received .. ''))
    end
  }
)
