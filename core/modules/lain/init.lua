
--[[
                                                   
     Lain                                          
     Layouts, widgets and utilities for Awesome WM 
                                                   
     Licensed under GNU General Public License v2  
      * (c) 2013, Luke Bonham                      
                                                   
--]]

package.loaded.lain = nil

local lain =
{
    layout  = require("core.modules.lain.layout"),
    util    = require("core.modules.lain.util"),
    widgets = require("core.modules.lain.widgets")
}

return lain
