local menugen = require("modules.menugen")
-- {{{ Auto-genereate menu from Awesome configs and plugins
local function createEditConfigurationsFileFromAwesome(name)
  local i, t, popen = 0, {}, io.popen

  for filename in popen ('ls '..name):lines()
  do
    i = i + 1
    t[i] = {
      [filename] = name.."/"..filename
    }
  end

  return t
end

local ConfigFiles,ThemesFiles, UserWidgetsFiles, GlobalWidgetsFiles = {}, {}, {}, {}

local function genMenu(array, path, prefix, exe)
  for k, v in pairs(createEditConfigurationsFileFromAwesome(path))
  do
    for kk, vv in pairs(v)
    do
      if prefix ~= nil and string.find(vv, prefix)
      then
        if string.find(vv, ".png")
        then
          command = "sxiv " .. vv
        else
          command = editor_cmd .. " " .. vv
        end
        table.insert(
          array,
          {
            kk,
            command,
            settings_icon
          }
        )
      elseif prefix == nil and prefix == '' and exe ~= nil and exe ~= ''
      then
        local command = editor_cmd .. " " .. vv .. '/init.lua'

        table.insert(
          array,
          {
            kk,
            command,
            settings_icon
          }
        )
      else
        if string.find(vv, ".png")
        then
          command = "sxiv " .. vv
        else
          command = editor_cmd .. " " .. vv
        end
        table.insert(
          array,
          {
            kk,
            command,
            settings_icon
          }
        )
      end
    end
  end
  return array
end

function generateMenu()
  -- Autogen Menu
  mymainmenu  = awful.menu.new(
    {
      items = menugen.build_menu(),
      theme =
      {
        height = 22,
        width = 240,
        border_width = 3,
        border_color = '#7788af'
      },
      {
        "Awesome",
        {
          {
            "Manual from Awesome",
            terminal .. " -e man awesome",
            help_icon
          },
          { "", },
          {
            "Edit Base Config",
            genMenu(ConfigFiles, awful.util.getdir("config")..'/config'),
          },
          {
            "Edit Theme Config",
            genMenu(ThemesFiles, awful.util.getdir("config")..'/themes/'..themename..'/', '.lua'),
          },
          {
            "Edit User Widgets Config",
            genMenu(UserWidgetsFiles, awful.util.getdir("config")..'/widgets/', nil, true),
          },
          {
            "Edit Global Widgets Config",
            genMenu(GlobalWidgetsFiles, awful.util.getdir("config")..'/modules/lain/widgets/'),
          },
          { "", },
          { "Update MultiColor", 'cd '..awful.util.getdir("config")..'; git pull;'},
          { "", },
          {
            "Awesome Restart",
            awesome.restart,
            beautiful.restart_icon
          },
          {
            "Awesome Quit",
            awesome.quit,
            beautiful.quit_icon
          }
        }
      },
      { "", },
      {
           "LockScreen",
           "xlock -mode ant3d",
           nil,
      },
      { "" },
      {
        "Browser",
        "FireFox",
        nil,
      },
      {
        "Terminal",
        terminal,
        nil,
      },
      {
        "FileManager",
        "urxvt -e ranger",
        nil,
      },
      {
        "E-mail",
        "urxvt -e mutt",
        nil,
      },
      { "" },
    }
  )
  return mymainmenu
end
-- }}}

return generateMenu