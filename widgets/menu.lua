local awful = require("awful")
local beautiful = require("beautiful")
local has_freedeskop = pcall(require, "freedesktop")
local menu_items = {}
local terminal_icon = beautiful.terminal_icon
local settings_icon = beautiful.settings_icon
local help_icon = beautiful.help_icon

if (has_freedesktop ~= nil) then
  local freedesktop = require("freedesktop")
  freedesktop.utils = require("freedesktop.utils")
  freedesktop.desktop = require("freedesktop.desktop")
  freedesktop.menu = require("freedesktop.menu")

  freedesktop.utils.terminal = terminal
  menu_items = freedesktop.menu.new()
  settings_icon = freedesktop.utils.lookup_icon({ icon = 'package_settings' })
  terminal_icon = freedesktop.utils.lookup_icon({icon = 'terminal'})
  help_icon = freedesktop.utils.lookup_icon({ icon = 'help' })
end

-- applications menu

local mycommons = {
	{ "Psi", "psi-plus" },
	{ "uzbl", "uzbl" },
	{ "skype", "skype" },
	{ "xchat", "xchat" },
	{ "Krusader", "krusader" }
}
table.insert(menu_items, 1, { "Common Apps", mycommons, beautiful.awesome_icon })
local myawesomemenu = {
	{ "manual", terminal .. " -e man awesome", help_icon },
	{ "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", settings_icon },
	{ "restart", awesome.restart, beautiful.restart_icon },
	{ "quit", awesome.quit, beautiful.quit_icon }
}
table.insert(menu_items, { "awesome", myawesomemenu, beautiful.awesome_icon })
table.insert(menu_items, { "open terminal", terminal, terminal_icon })

mymainmenu = awful.menu.new({ items = menu_items })
-- menu is also used in bindings, it can't be local

return awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
