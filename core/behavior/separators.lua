-- {{{ Separators
separators = _Awesome.lain.util.separators
_spr = _Awesome.wibox.widget.textbox(' ')
arrl = _Awesome.wibox.widget.imagebox()
arrl:set_image(_Awesome.beautiful.arrl)
arrl_dl = separators.arrow_left(_Awesome.beautiful.bg_focus, "alpha")
arrl_ld = separators.arrow_left("alpha", _Awesome.beautiful.bg_focus)
decor = _Awesome.wibox.widget.imagebox()
decor:set_image(_Awesome.beautiful.decor)
decor_blue = _Awesome.wibox.widget.imagebox()
decor_blue:set_image(_Awesome.beautiful.decor_blue)
volicon = _Awesome.wibox.widget.imagebox()
volicon:set_image(_Awesome.beautiful.widget_vol)
spacer = _Awesome.wibox.widget.textbox()
separator = _Awesome.wibox.widget.imagebox()
spacer:set_text(" ")
separator:set_image(_Awesome.beautiful.widget_sep)
-- }}}

-- {{{ Markup
markup = _Awesome.lain.util.markup
space3 = markup.font("Hack 3", " ")
space2 = markup.font("Hack 2", " ")
vspace1 = '<span font="Hack 3"> </span>'
vspace2 = '<span font="Hack 3">  </span>'

spr = _Awesome.wibox.widget.imagebox()
spr:set_image(_Awesome.beautiful.spr)
spr4px = _Awesome.wibox.widget.imagebox()
spr4px:set_image(_Awesome.beautiful.spr4px)
spr5px = _Awesome.wibox.widget.imagebox()
spr5px:set_image(_Awesome.beautiful.spr5px)

widget_display = _Awesome.wibox.widget.imagebox()
widget_display:set_image(_Awesome.beautiful.widget_display)
widget_display_r = _Awesome.wibox.widget.imagebox()
widget_display_r:set_image(_Awesome.beautiful.widget_display_r)
widget_display_l = _Awesome.wibox.widget.imagebox()
widget_display_l:set_image(_Awesome.beautiful.widget_display_l)
widget_display_c = _Awesome.wibox.widget.imagebox()
widget_display_c:set_image(_Awesome.beautiful.widget_display_c)
-- }}}
