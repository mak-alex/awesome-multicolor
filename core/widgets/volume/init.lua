volumewidget = _Awesome.lain.widgets.alsa(
  {
    settings = function()
      if volume_now.status == "off" then
        volume_now.level = volume_now.level .. "M"
      end

      widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
    end
})

