--- Shortcuts ....
---- @author  Alexandr Mikhailenko a.k.a. Alex M.A.K. <alex-m.a.k@yandex.kz>
---- @release $Id: $
---- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
---- vim: retab 
--
local awful       = require("awful")
local wibox       = require("wibox")
local oapi        = { screen = screen }
-------------------------------------------------------------------------------
--  Задаем параметры виджета
-------------------------------------------------------------------------------
local scrn        = oapi.screen[1].geometry
hotkeys           = {}
hotkeys.width     = 600
hotkeys.height    = 660
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
hotkeys_wbox = wibox({bg = "#0D151D", width = hotkeys.width, height = hotkeys.height, border_width=3, border_color="#7788af"})
hotkeys_wbox.visible = false
hotkeys_wbox.ontop = true
hotkeys_wbox:geometry({ x = ((scrn.width)/2)-200, y = ((scrn.height)/2)-330})
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
local title = wibox.widget.textbox()
title:set_align("center")
title:set_valign("top")
 
local main = wibox.widget.textbox()
main:set_align("left")
main:set_valign("top")

local title_str = [[<span font_desc="hack 14" color="#99ac3a" underline="none">Basic keyboard shortcuts</span>]]
local main_text = [[
    <span font="hack 11" color='#87af5f'><b>MPD (MUSIC SERVER):</b></span>
      <span font="" color='#e33a6e'>mpc|ncmpc|pms next:</span>     <span font="" color='#87af5f'>Alt+Shift+(arrow_right)</span>
      <span font="" color='#e33a6e'>mpc|ncmpc|pms prev:</span>     <span font="" color='#87af5f'>Alt+Shift+(arrow_left)</span>
      <span font="" color='#e33a6e'>mpc|ncmpc|pms toggle:</span>   <span font="" color='#87af5f'>Alt+Shift+(arrow_up)</span>
      <span font="" color='#e33a6e'>mpc|ncmpc|pms stop:</span>     <span font="" color='#87af5f'>Alt+Shift+(arrow_down)</span>
    <span font="hack 11" color='#e54c62'><b>ALSA:</b></span>
      <span font="" color='#f1af5f'>volume up:</span>              <span font="" color='#e54c62'>Alt+(arrow_up)</span>
      <span font="" color='#f1af5f'>volume down:</span>            <span font="" color='#e54c62'>Alt+(arrow_down)</span>
      <span font="" color='#f1af5f'>volume mute|unmute:</span>     <span font="" color='#e54c62'>Alt+m</span>
      <span font="" color='#f1af5f'>volume 100%:</span>            <span font="" color='#e54c62'>Alt+Ctrl+m</span>
    <span font="hack 11" color='#7493d2'><b>DYNAMIC TAGS:</b></span>
      <span font="" color='#80d9d8'>delete_tag:</span>             <span font="" color='#7493d2'>Win+d</span>
      <span font="" color='#80d9d8'>new tag:</span>                <span font="" color='#7493d2'>Win+n</span>
      <span font="" color='#80d9d8'>move to new tag:</span>        <span font="" color='#7493d2'>Win+Alt+n</span>
      <span font="" color='#80d9d8'>rename tag to focussed:</span> <span font="" color='#7493d2'>Win+Alt+r</span>
      <span font="" color='#80d9d8'>rename tag:</span>             <span font="" color='#7493d2'>Win+Shift+r</span>
      <span font="" color='#80d9d8'>term in current  tag:</span>   <span font="" color='#7493d2'>Win+Alt+enter</span>
      <span font="" color='#80d9d8'>new tag with term:</span>      <span font="" color='#7493d2'>Win+Ctrl+enter</span>
      <span font="" color='#80d9d8'>fork tag:</span>               <span font="" color='#7493d2'>Win+Ctrl+f</span>
      <span font="" color='#80d9d8'>aero tag:</span>               <span font="" color='#7493d2'>Win+a</span>
      <span font="" color='#80d9d8'>tag view prev:</span>          <span font="" color='#7493d2'>Win+(arrow_left)</span>
      <span font="" color='#80d9d8'>tag view next:</span>          <span font="" color='#7493d2'>Win+(arrow_right)</span>
      <span font="" color='#80d9d8'>tag history restore:</span>    <span font="" color='#7493d2'>Win+Escape</span>
    <span font="hack 11" color='#e0da37'><b>TERMINAL:</b></span>
      <span font="" color='#eca4c4'>new terminal:</span>           <span font="" color='#e0da37'>Win+enter</span>
      <span font="" color='#eca4c4'>dropdown terminal:</span>      <span font="" color='#e0da37'>Win+z</span>
    <span font="hack 11" color='#e33a6e'><b>WINDOW:</b></span>
      <span font="" color='#e0da37'>open window fullscreen:</span> <span font="" color='#e33a6e'>Win+f</span>
      <span font="" color='#e0da37'>maximized hor and vert:</span> <span font="" color='#e33a6e'>Win+m</span>
      <span font="" color='#e0da37'>kill window:</span>            <span font="" color='#e33a6e'>Win+Shift+c</span>
      <span font="" color='#e0da37'>floating window:</span>        <span font="" color='#e33a6e'>Win+Ctrl+space</span>
      <span font="" color='#e0da37'>move left:</span>              <span font="" color='#e33a6e'>Win+h</span> 
      <span font="" color='#e0da37'>move right:</span>             <span font="" color='#e33a6e'>Win+l</span>
      <span font="" color='#e0da37'>move up:</span>                <span font="" color='#e33a6e'>Win+k</span> 
      <span font="" color='#e0da37'>move down:</span>              <span font="" color='#e33a6e'>Win+j</span>
      <span font="" color='#e0da37'>byid +1:</span>                <span font="" color='#e33a6e'>Alt+j</span>
      <span font="" color='#e0da37'>byid -1:</span>                <span font="" color='#e33a6e'>Alt+k</span>
    <span font="hack 11" color='#f1af5f'><b>PANEL:</b></span>
      <span font="" color='#7493d2'>hide panels:</span>            <span font="" color='#f1af5f'>Win+b</span>
    <span font="hack 11" color='#80d9d8'><b>MENU:</b></span>
      <span font="" color='#e54c62'>open dynamic menu:</span>      <span font="" color='#80d9d8'>Win+w</span>
    <span font="hack 11" color='#eca4c4'><b>AWESOME:</b></span>
      <span font="" color='#87af5f'>restart wm:</span>             <span font="" color='#eca4c4'>Win+Ctrl+enter</span>
      <span font="" color='#87af5f'>quit wm:</span>                <span font="" color='#eca4c4'>Win+Shift+q</span>
  <span font="hack 10" color='#de5e1e'>Please click with the F1 to exit</span>]]

title:set_markup('<span font_desc="hack 16" color="#99ac3a" underline="single">'..title_str..'</span>')
main:set_markup('<span font_desc="hack 12" color="gray">'..main_text..'</span>') 
-------------------------------------------------------------------------------
--  Кладем виджет на wibox
-------------------------------------------------------------------------------
local hotkeys_layout = wibox.layout.fixed.vertical()
hotkeys_layout:add(title)
hotkeys_layout:add(main)
hotkeys_wbox:set_widget(hotkeys_layout)
hotkeys.wibox = hotkeys_wbox

return hotkeys
