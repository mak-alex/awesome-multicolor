-- Generator general menu
--- @author  Alexandr Mikhailenko a.k.a. Alex M.A.K. <alex-m.a.k@yandex.kz>
--- @release $Id: $
--- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
--
local menugen = require("modules.menugen")
--local posix = require "posix"

mythememenu = {}

function removeOldTheme()
  local cfg_path = awful.util.getdir("config")
  local cmd = "ls -1 " .. cfg_path .. "/themes/.usedTheme/"

  local f = io.popen(cmd)
  for l in f:lines() do
    awful.util.spawn("rm " .. cfg_path .. "/themes/.usedTheme/"..l)
  end
  f:close()
end

function theme_load(theme)
   local cfg_path = awful.util.getdir("config")
   local home_path = os.getenv('HOME')

  -- Create a symlink from the given theme to /home/user/.config/awesome/current_theme
  removeOldTheme()
  --local status, errstr = posix.link(cfg_path.."/themes/"..theme, cfg_path.."/themes/.usedTheme/"..theme, true)
  awful.util.spawn("ln -sfn " .. cfg_path .. "/themes/" .. theme .. " " .. cfg_path ..  "/themes/.usedTheme/" .. theme)
  --local status, errstr = posix.link(cfg_path.."/themes/"..theme.."/Xdefaults", home_path .. "/.Xdefaults", true)
  awful.util.spawn("ln -sfn " .. cfg_path.."/themes/"..theme.."/Xdefaults " .. home_path .. "/.Xdefaults")
  awesome.restart()
end

function theme_menu()
   -- List your theme files and feed the menu table
   local cmd = "ls -1 " .. awful.util.getdir("config") .. "/themes/"
   local f = io.popen(cmd)

   for l in f:lines() do
    local item = { l, function () theme_load(l) end }
    table.insert(mythememenu, item)
   end

   f:close()
end

-- Generate your table at startup or restart
theme_menu()


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
          command = userConfig.editor_cmd .. " " .. vv
        end
        table.insert(
          array,
          {
            kk,
            command,
            beautiful.file
          }
        )
      elseif prefix == nil and prefix == '' and exe ~= nil and exe ~= ''
      then
        local command = userConfig.editor_cmd .. " " .. vv .. '/init.lua'

        table.insert(
          array,
          {
            kk,
            command,
            beautiful.file
          }
        )
      else
        if string.find(vv, ".png")
        then
          command = "sxiv " .. vv
        else
          command = userConfig.editor_cmd .. " " .. vv
        end
        table.insert(
          array,
          {
            kk,
            command,
            beautiful.file
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
            userConfig.terminal .. " -e man awesome",
            beautiful.awesomeManual
          },
          { "", },
          {
            "Edit Base Config",
            genMenu(ConfigFiles, awful.util.getdir("config")..'/config'),
            beautiful.sourceEdit
          },
          {
            "Edit Theme Config",
            genMenu(ThemesFiles, awful.util.getdir("config")..'/themes/'..themename..'/', '.lua'),
            beautiful.sourceEdit
          },
          {
            "Edit User Widgets Config",
            genMenu(UserWidgetsFiles, awful.util.getdir("config")..'/widgets/', nil, true),
            beautiful.sourceEdit
          },
          {
            "Edit Global Widgets Config",
            genMenu(GlobalWidgetsFiles, awful.util.getdir("config")..'/modules/lain/widgets/'),
            beautiful.sourceEdit
          },
          { "", },
          { "Update MultiColor", 'cd '..awful.util.getdir("config")..'; git pull;', beautiful.updateAwesome },
          { "", },
          { "Awesome Themes", mythememenu, beautiful.themesAwesome },
          {
            "Awesome Restart",
            awesome.restart,
            beautiful.restart
          }
        },
        beautiful.awesomewm
      },
      { "" },
      {
        "Browser",
        "FireFox",
        beautiful.browser,
      },
      {
        "Terminal",
        userConfig.terminal,
        beautiful.console,
      },
      {
         "IM Client",
         userConfig.browser .. ' "https://plus.im/"',
         beautiful.im
      },
      {
        "FileManager",
        "urxvtc -name ranger -e ranger",
        beautiful.filemanager,
      },
      {
        "E-mail",
        userConfig.browser .. ' "https://mail.yandex.kz"',
        beautiful.email,
      },
      {
         "Photo Editor",
         userConfig.browser .. ' "https://www.befunky.com/create/"',
         beautiful.photoeditor
      },
      {},
      {
        "Music Online",
        {
          {
            "Yandex.Radio",
            {
              {
                "Main",
                userConfig.browser .. ' "https://radio.yandex.kz"',
                nil,
              },
              {
                "Metal",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/metal"',
                nil,
              },
              {
                "Alternative",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/alternative"',
                nil,
              },
              {
                "Blues",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/blues"',
                nil,
              },
              {
                "SKA",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/ska"',
                nil,
              },
              {
                "Estrada",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/estrada"',
                nil,
              },
              {
                "Shanson",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/shanson"',
                nil,
              },
              {
                "Country",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/country"',
                nil,
              },
              {
                "Children",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/children"',
                nil,
              },
              {
                "Electronics",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/electronics"',
                nil,
              },
              {
                "Dubstep",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/dubstep"',
                nil,
              },
              {
                "Industrial",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/industrial"',
                nil,
              },
              {
                "Experimental",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/experimental"',
                nil,
              },
              {
                "Dance",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/dance"',
                nil,
              },
              {
                "House",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/house"',
                nil,
              },
              {
                "Techno",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/techno"',
                nil,
              },
              {
                "Trance",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/trance"',
                nil,
              },
              {
                "DNB",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/dnb"',
                nil,
              },
              {
                "Relax",
                userConfig.browser .. ' "https://radio.yandex.kz/genre/relax"',
                nil,
              },
            },
            beautiful.radio_yandex
          },
          {
            "Yandex.Music",
            userConfig.browser .. ' "https://music.yandex.kz"',
            beautiful.music_yandex,
          },
          {
            "101",
            userConfig.browser .. ' "https://101.ru"',
            beautiful.ru101,
          },
          {
            "DI",
            userConfig.browser .. ' "https://di.fm"',
            beautiful.di,
          },
        },
        beautiful.music
      },
      { "", },
      {
        "Applications",
        menugen.build_menu(),
        beautiful.applications
      },
      {
        "Google Applications",
        {
          {
            "Create spreadsheet",
            userConfig.browser .. ' "https://docs.google.com/spreadsheet/ccc?new"',
            beautiful.play_sheets
          },
          {
            "Create document",
            userConfig.browser .. ' "https://docs.google.com/document/create"',
            beautiful.play_docs
          },
          {
            "Create presentation",
            userConfig.browser .. ' "https://docs.google.com/presentation/create"',
            beautiful.play_slides
          },
          {
            "Create draw",
            userConfig.browser .. ' "https://docs.google.com/drawings/create?usp=drive_web"',
            beautiful.play_drawings
          },
          {
            "Create form",
            userConfig.browser .. ' "https://docs.google.com/forms/create"',
            beautiful.play_forms
          },
          { "", },
          {
            "Google Sheets",
            userConfig.browser .. ' "https://docs.google.com/spreadsheets/u/0/"',
            beautiful.play_sheets
          },
          {
            "Google Docks",
            userConfig.browser .. ' "https://docs.google.com/document/u/0/"',
            beautiful.play_docs
          },
          {
            "Google Disk",
            userConfig.browser .. ' "https://drive.google.com/drive/u/0/"',
            beautiful.play_drive
          },
          {
            "Google Hangouts",
            userConfig.browser .. ' "https://hangouts.google.com/"',
            beautiful.play_hangouts
          },
          {
            "Google Calendar",
            userConfig.browser .. ' "https://calendar.google.com/calendar/"',
            beautiful.play_calendar
          },
          {
            "Google Contacts",
            userConfig.browser .. ' "https://contacts.google.com/u/0/preview/all"',
            beautiful.play_contacts
          },
          {
            "Google Books",
            userConfig.browser .. ' "https://play.google.com/books?source=gbs_lp_bookshelf_list"',
            beautiful.play_books
          },
          {
            "Google News",
            userConfig.browser .. ' "https://news.google.com/nwshp?hl=ru"',
            beautiful.play_news
          },
          {
            "Google Inbox",
            userConfig.browser .. ' "https://inbox.google.com/u/0/"',
            beautiful.play_inbox
          }
        },
        beautiful.google_apps
      },
      {
        "Develop",
        {
          {
            "Lua Functions",
            {
              {
                "5.1",
                userConfig.browser .. ' "http://www.lua.org/manual/5.1/index.html#index"'
              },
              {
                "5.2",
                userConfig.browser .. ' "http://www.lua.org/manual/5.2/index.html#index"'
              },
              {
                "5.3",
                userConfig.browser .. ' "http://www.lua.org/manual/5.3/index.html#index"'
              }
            },
            beautiful.lualogo
          },
          {
            "A curated list of quality Lua packages and resources",
            userConfig.browser .. ' "https://github.com/LewisJEllis/awesome-lua"',
            beautiful.lualogo
          },
          {
            "Cloud9",
            userConfig.browser .. ' "https://ide.c9.io/"',
            beautiful.cloud9
          }
        },
        beautiful.develop
      },
      { "", },
      {
           "LockScreen",
           "xlock -mode ant3d",
           beautiful.lockscreen
      },
      {
            "Restart",
            'systemctl restart -i',
            beautiful.restart
      },
      {
            "Poweroff",
            'systemctl poweroff -i',
            beautiful.poweroff
      },
    }
  )
  return mymainmenu
end
-- }}}

return generateMenu
