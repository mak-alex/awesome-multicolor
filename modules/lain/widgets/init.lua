
--[[
                                                   
     Lain                                          
     Layouts, widgets and utilities for Awesome WM 
                                                   
     Widgets section                               
                                                   
     Licensed under GNU General Public License v2  
      * (c) 2013,      Luke Bonham                 
      * (c) 2010-2012, Peter Hofmann               
                                                   
--]]

local wrequire     = require("modules.lain.helpers").wrequire
local setmetatable = setmetatable

local widgets = { _NAME = "modules.lain.widgets" }

return setmetatable(widgets, { __index = wrequire })
