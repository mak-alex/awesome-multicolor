--- Generator general menu
---- @author  Alexandr Mikhailenko a.k.a. Alex M.A.K. <alex-m.a.k@yandex.kz>
---- @release $Id: $
---- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
---- vim: retab 
--
local menugen = require("modules.menugen")
local posix = require "posix"

mythememenu = {}

function removeOldTheme()
  local cfg_path = awful.util.getdir("config")
  local oldTheme = posix.dir(cfg_path.."/themes/.usedTheme/")[2]
  posix.rmdir(cfg_path.."/themes/.usedTheme/"..oldTheme)
end

function theme_load(theme)
   local cfg_path = awful.util.getdir("config")
   local home_path = os.getenv('HOME')

  -- Create a symlink from the given theme to /home/user/.config/awesome/current_theme
  removeOldTheme()
  local status, errstr = posix.link(cfg_path.."/themes/"..theme, cfg_path.."/themes/.usedTheme/"..theme, true)
  local status, errstr = posix.link(cfg_path.."/themes/"..theme.."/Xdefaults", home_path .. "/.Xdefaults", true)
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
        "Applications",
        menugen.build_menu(),
        beautiful.applications
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
      { "", },
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
        "FileManager",
        "urxvtc -name ranger -e ranger",
        beautiful.filemanager,
      },
      {
        "E-mail",
        "urxvtc -name mutt -e mutt",
        beautiful.email,
      },
    }
  )
  return mymainmenu
end
-- }}}

return generateMenu
