local MULTICOLOR = {
  _NAME = "FH-MultiColor",
  _VERSION = 'MULTICOLOR v0.1.0-rc1',
  _URL = 'https://bitbucket.org/enlab/multicolor',
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
  	Failsafe mode
	If the current config fail, load the default awesome.defaults.lua
  	]]
}
awful           = require('awful')
naughty         = require('naughty')
confdir         = awful.util.getdir("config")
local file      = require('modules.file')
local rc, err   = loadfile(confdir .. "/config/awesome.lua");
if rc then rc, err = pcall(rc); if rc then file.copy(confdir.."/config/awesome.lua",confdir.."/config/.awesome.defaults.lua") return end end
dofile(confdir .. "/config/.awesome.defaults.lua")
print ("Awesome crashed during startup on " .. os.date("%d/%m/%Y %T:\n\n") .. err .. "\n\n\
  Please send an error report to flashhacker1988@gmail.com")
naughty.notify{
  text="<span color='#87af5f'>RESERVE MODE::Awesome crashed during startup on</span> <span color='#e54c62'>" .. os.date("%d/%m/%Y %T</span>:\n\n<span color='#87af5f'>NAME CONF</span>: ")  
  ..MULTICOLOR._NAME..'\n<span color="#87af5f">VERSION CONF</span>: '..MULTICOLOR._VERSION..'\n<span color="#87af5f">GIT URL</span>: '..MULTICOLOR._URL .. '\n<span color="#87af5f">ERROR</span>: ' .. err .. "\n\n\
  <span color='#80d9d8'>Please send an error report to</span> <span color='#7788af'>"..MULTICOLOR._MAIL.."</span>\n",
  timeout = 0, border_color = "#fdd9d8", border_width = 1,
}
