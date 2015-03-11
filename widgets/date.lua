-- Date and time
local vicious = require("vicious")
local wibox = require("wibox")
datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, "%d %b, %R", 60)
return datewidget
