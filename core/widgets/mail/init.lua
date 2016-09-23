  -- | Mail | --
mail_widget = _Awesome.wibox.widget.textbox()
_Awesome.vicious.register(mail_widget, _Awesome.vicious.widgets.gmail, vspace1 .. "${count}" .. vspace1, 1200)

widget_mail = _Awesome.wibox.widget.imagebox()
widget_mail:set_image(_Awesome.beautiful.widget_mail)
mailwidget = _Awesome.wibox.widget.background()
mailwidget:set_widget(mail_widget)
mailwidget:set_bgimage(_Awesome.beautiful.widget_display)

return mail_widget, mailwidget
