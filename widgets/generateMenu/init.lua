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
          command = editor_cmd .. " " .. vv
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
        local command = editor_cmd .. " " .. vv .. '/init.lua'

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
          command = editor_cmd .. " " .. vv
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
            terminal .. " -e man awesome",
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
        terminal,
        beautiful.console,
      },
      {
         "IM Client",
         browser .. ' --new-tab "https://plus.im/"',
         beautiful.im
      },
      {
        "FileManager",
        "urxvtc -name ranger -e ranger",
        beautiful.filemanager,
      },
      {
        "E-mail",
        browser .. ' --new-tab "https://mail.yandex.kz"',
        beautiful.email,
      }, 
      {
         "Photo Editor",
         browser .. ' --new-tab "https://www.befunky.com/create/"',
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
                browser .. ' --new-tab "https://radio.yandex.kz"',
                nil,
              },
              {
                "Metal",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/metal"',
                nil,
              },
              {
                "Alternative",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/alternative"',
                nil,
              },
              {
                "Blues",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/blues"',
                nil,
              },
              {
                "SKA",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/ska"',
                nil,
              },
              {
                "Estrada",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/estrada"',
                nil,
              },
              {
                "Shanson",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/shanson"',
                nil,
              },
              {
                "Country",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/country"',
                nil,
              },
              {
                "Children",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/children"',
                nil,
              },
              {
                "Electronics",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/electronics"',
                nil,
              },
              {
                "Dubstep",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/dubstep"',
                nil,
              },
              {
                "Industrial",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/industrial"',
                nil,
              },
              {
                "Experimental",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/experimental"',
                nil,
              },
              {
                "Dance",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/dance"',
                nil,
              },
              {
                "House",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/house"',
                nil,
              },
              {
                "Techno",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/techno"',
                nil,
              },
              {
                "Trance",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/trance"',
                nil,
              },
              {
                "DNB",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/dnb"',
                nil,
              },
              {
                "Relax",
                browser .. ' --new-tab "https://radio.yandex.kz/genre/relax"',
                nil,
              },
            },
            beautiful.radio_yandex
          },
          {
            "Yandex.Music",
            browser .. ' --new-tab "https://music.yandex.kz"',
            beautiful.music_yandex,
          },
          {
            "101",
            browser .. ' --new-tab "https://101.ru"',
            beautiful.ru101,
          },
          {
            "DI",
            browser .. ' --new-tab "https://di.fm"',
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
            browser .. ' --new-tab "https://docs.google.com/spreadsheet/ccc?new"',
            beautiful.play_sheets
          },
          {
            "Create document",
            browser .. ' --new-tab "https://docs.google.com/document/create"',
            beautiful.play_docs
          },
          {
            "Create presentation",
            browser .. ' --new-tab "https://docs.google.com/presentation/create"',
            beautiful.play_slides
          },
          {
            "Create draw",
            browser .. ' --new-tab "https://docs.google.com/drawings/create?usp=drive_web"',
            beautiful.play_drawings
          },
          {
            "Create form",
            browser .. ' --new-tab "https://docs.google.com/forms/create"',
            beautiful.play_forms
          },
          { "", },
          {
            "Google Sheets",
            browser .. ' --new-tab "https://docs.google.com/spreadsheets/u/0/"',
            beautiful.play_sheets
          },
          {
            "Google Docks",
            browser .. ' --new-tab "https://docs.google.com/document/u/0/"',
            beautiful.play_docs
          },
          {
            "Google Disk",
            browser .. ' --new-tab "https://drive.google.com/drive/u/0/"',
            beautiful.play_drive
          },
          {
            "Google Hangouts",
            browser .. ' --new-tab "https://hangouts.google.com/"',
            beautiful.play_hangouts
          },
          {
            "Google Calendar",
            browser .. ' --new-tab "https://calendar.google.com/calendar/"',
            beautiful.play_calendar
          },
          {
            "Google Contacts",
            browser .. ' --new-tab "https://contacts.google.com/u/0/preview/all"',
            beautiful.play_contacts
          },
          {
            "Google Books",
            browser .. ' --new-tab "https://play.google.com/books?source=gbs_lp_bookshelf_list"',
            beautiful.play_books
          },
          {
            "Google News",
            browser .. ' --new-tab "https://news.google.com/nwshp?hl=ru"',
            beautiful.play_news
          },
          {
            "Google Inbox",
            browser .. ' --new-tab "https://inbox.google.com/u/0/"',
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
                browser .. ' --new-tab "http://www.lua.org/manual/5.1/index.html#index"'
              },
              {
                "5.2",
                browser .. ' --new-tab "http://www.lua.org/manual/5.2/index.html#index"'
              },
              {
                "5.3",
                browser .. ' --new-tab "http://www.lua.org/manual/5.3/index.html#index"'
              }
            },
            beautiful.lualogo
          },
          {
            "A curated list of quality Lua packages and resources",
            browser .. ' --new-tab "https://github.com/LewisJEllis/awesome-lua"',
            beautiful.lualogo
          },
          {
            "Cloud9",
            browser .. ' --new-tab "https://ide.c9.io/"',
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
