-- {{ GMail Widget }} --
mailicon = wibox.widget.imagebox()
vicious.register(mailicon, vicious.widgets.gmail, function(widget, args)
local newMail = tonumber(args["{count}"])
   if newMail > 0 then
     mailicon:set_image(beautiful.mail)
   else
     mailicon:set_image(beautiful.mailopen)
   end
end, 15)