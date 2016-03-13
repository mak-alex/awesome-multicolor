
--[[
                                                   
     Lain                                          
     Layouts, widgets and utilities for Awesome WM 
                                                   
     Users contributed widgets section             
                                                   
     Licensed under GNU General Public License v2  
      * (c) 2013,      Luke Bonham                 
                                                   
--]]

local wrequire     = require("modules.lain.helpers").wrequire
local setmetatable = setmetatable

local widgets = { _NAME = "modules.lain.widgets.contrib" }

return setmetatable(widgets, { __index = wrequire })
