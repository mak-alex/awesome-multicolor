--- Backup and Restore general configuration from fail start
---- @author  Alexandr Mikhailenko a.k.a. Alex M.A.K. <alex-m.a.k@yandex.kz>
---- @release $Id: $
---- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
---- vim: retab 
--
awful           = require('awful')
naughty         = require('naughty')
confdir         = awful.util.getdir("config")
local file      = require('modules.file')
local rc, err   = loadfile(confdir .. "/config/awesome.lua");
if rc then rc, err = pcall(rc); if rc then file.copy(confdir.."/config/awesome.lua",confdir.."/config/.awesome.defaults.lua") return end end
dofile(confdir .. "/config/.awesome.defaults.lua")
print ("Awesome crashed during startup on " .. os.date("%d/%m/%Y %T:\n\n") .. err .. "\n\n\
  Please send an error report to flashhacker1988@gmail.com")

naughty.notify {
  text = "[BACKUP]: Restore Multicolor Configuration from Awesome 3.5\n" ..
  '\n[NAME]: MultiColor' ..
  '\n[VER.]: '.."2.0"..
  '\n[URL]: '.. 'https://bitbucket.org/enlab/multicolor' .. 
  '\n[PATH]: ' .. confdir.."/config/.awesome.defaults.lua"..
  '\n[ERROR]: ' .. err ..
  '\n\nPlease try to fix the error in the main configuration file and restart Awesome!' ..
  '\nIf you can not fix the error yourself, contact the developer!\n' ..
  "\n\nCoded by Alexandr Mikhailenko a.k.a. Alex M.A.K. "..'<alex-m.a.k@yandex.kz>'.."\n",
  ontop = true, 
  border_color = "#7788af", 
  border_width = 3, 
  timeout = 60, 
  position   = "top_right"
}

--- {{{ USER CONFIGURATION
--[[
  Your frequently used applications.
Please change if something is not the same ...
]]--
app={
  ["browser"]="firefox",
  ["terminal"]="urxvt",
  ["graphic"]="gimp",
  ["develop"]="urxvt -e vim",
}
-- Status dynamic tags: true - on dynamic tags / false - off dynamic tags
dynamic_tagging = true

-- Theme: defines colours, icons, and wallpapers
themename =  "pro-dark" -- "dark" or "multicolor" or "pro-light" or "pro-dark" or "pro-gotham" or "pro-medium-dark" or "pro-medium-light"
---}}}