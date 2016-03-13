
--[[
                                                   
     Lain                                          
     Layouts, widgets and utilities for Awesome WM 
                                                   
     Licensed under GNU General Public License v2  
      * (c) 2013, Luke Bonham                      
                                                   
--]]

package.loaded.lain = nil

local lain =
{
    layout  = require("modules.lain.layout"),
    util    = require("modules.lain.util"),
    widgets = require("modules.lain.widgets")
}

return lain
