local FHMenuGen = {
  _NAME = "FH-MenuGen",
  _VERSION = 'FH-MenuGen v0.1.0-rc1',
  _URL = 'https://bitbucket.org/enlab/menugen',
  _MAIL = 'flashhacker1988@gmail.com',
  _LICENSE = [[
    MIT LICENSE
    Copyright (c) 2015 Mikhailenko Alexandr Konstantinovich (a.k.a) Alex M.A.K
    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]],
  _DESCRIPTION = [[
    Drop-down applications menu for the awesome window manager
      To use this module add:
        mymainmenu = awful.menu.new({ items = require("menugen").build_menu(),
                                      theme = { height = 16, width = 130 }})
    ]]
}
local menu_gen = require("menubar.menu_gen")
local menu_utils = require("menubar.utils")
local pairs,ipairs,table,string,next=pairs,ipairs,table,string,next
module("menugen")
--Built in menubar should be checking local applications directory
menu_gen.all_menu_dirs = { 
   '/usr/share/applications/', 
   '/usr/local/share/applications/', 
   '~/.local/share/applications' 
}
--Expecting an wm_name of awesome omits too many applications and tools
menu_utils.wm_name = ""
-- Use MenuBar Parsing Utils to build StartMenu for Awesome
-- @return awful.menu compliant menu items tree
function build_menu()
  local result = {}
  local menulist = menu_gen.generate()
  for k,v in pairs(menu_gen.all_categories) do
    table.insert(result, {k, {}, v["icon"] } )
  end
  for k, v in ipairs(menulist) do
    for _, cat in ipairs(result) do
      if cat[1] == v["category"] then
        table.insert( cat[2] , { v["name"], v["cmdline"], v["icon"] } )
        break
      end
    end
  end
  -- Cleanup Things a Bit
  for k,v in ipairs(result) do
    -- Remove Unused Categories
    if not next(v[2]) then
      table.remove(result, k)
    else
      --Sort entries Alphabetically (by Name)
      table.sort(v[2], function (a,b) return string.byte(a[1]) < string.byte(b[1]) end)
      -- Replace Catagory Name with nice name
      v[1] = menu_gen.all_categories[v[1]].name
    end
  end
  --Sort Categories Alphabetically Also
  table.sort(result, function(a,b) return string.byte(a[1]) < string.byte(b[1]) end)
  return result
end
