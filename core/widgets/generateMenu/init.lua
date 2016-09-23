-- Generator general menu
--- @author  Alexandr Mikhailenko a.k.a. Alex M.A.K. <alex-m.a.k@yandex.kz>
local menugen = require("core.modules.menugen")

mythememenu = {}
function removeOldTheme()
  local cfg_path = _Awesome.config
  local cmd = "ls -1 " .. cfg_path .. "/themes/.usedTheme/"

  local f = io.popen(cmd)
  for l in f:lines() do
    _Awesome.awful.util.spawn("rm " .. cfg_path .. "/themes/.usedTheme/"..l)
  end
  f:close()
end

function theme_load(theme)
   local cfg_path = _Awesome.config
   local home_path = os.getenv('HOME')

  -- Create a symlink from the given theme to /home/user/.config/awesome/current_theme
  removeOldTheme()
  _Awesome.awful.util.spawn("ln -sfn " .. cfg_path .. "/themes/" .. theme .. " " .. cfg_path ..  "/themes/.usedTheme/" .. theme)
  _Awesome.awful.util.spawn("ln -sfn " .. cfg_path.."/themes/"..theme.."/Xdefaults " .. home_path .. "/.Xdefaults")
  awesome.restart()
end

function theme_menu()
   -- List your theme files and feed the menu table
   local cmd = "ls -1 "
    .. _Awesome.config
    .. "/themes/"
   local f = io.popen(cmd)

   for l in f:lines() do
     if l ~= 'init.lua' and not string.find(l, 'Xdefaults')
     then
       table.insert(
         mythememenu,
         {
           l,
           function ()
             theme_load(l)
           end
         }
       )
     end
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
          command = _Awesome.applications.editor .. " " .. vv
        end
        table.insert(
          array,
          {
            kk,
            command,
            _Awesome.beautiful.file
          }
        )
      elseif prefix == nil and prefix == '' and exe ~= nil and exe ~= ''
      then
        local command = _Awesome.applications.editor .. " " .. vv .. '/init.lua'

        table.insert(
          array,
          {
            kk,
            command,
            _Awesome.beautiful.file
          }
        )
      else
        if string.find(vv, ".png")
        then
          command = "sxiv " .. vv
        else
          command = _Awesome.applications.editor .. " " .. vv
        end
        table.insert(
          array,
          {
            kk,
            command,
            _Awesome.beautiful.file
          }
        )
      end
    end
  end
  return array
end

function generateMenu()
  -- Autogen Menu
  mymainmenu  = _Awesome.awful.menu.new(
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
            'urxvt', --_Awesome.userConfig.terminal.command .. " -e man awesome",
            _Awesome.beautiful.awesomeManual
          },
          { "", },
          {
            "Edit Base Config",
            genMenu(
              ConfigFiles,
              _Awesome.config
                ..'/core/root'
            ),
            _Awesome.beautiful.sourceEdit
          },
          {
            "Edit Theme Config",
            genMenu(
              ThemesFiles,
              _Awesome.config
                ..'/themes/'
                .._Awesome.themename
                ..'/',
              '.lua'
            ),
            _Awesome.beautiful.sourceEdit
          },
          {
            "Edit User Widgets Config",
            genMenu(
              UserWidgetsFiles,
              _Awesome.config
                ..'/core/widgets/',
              nil,
              true
            ),
            _Awesome.beautiful.sourceEdit
          },
          {
            "Edit Global Widgets Config",
            genMenu(
              GlobalWidgetsFiles,
              _Awesome.config
                ..'/core/modules/lain/widgets/'
            ),
            _Awesome.beautiful.sourceEdit
          },
          { "", },
          {
            "Update MultiColor",
            'cd '
              .. _Awesome.config
              .. '; git pull;',
            _Awesome.beautiful.updateAwesome
          },
          { "", },
          {
            "Awesome Themes",
            mythememenu,
            _Awesome.beautiful.themesAwesome
          },
          {
            "Awesome Restart",
            awesome.restart,
            _Awesome.beautiful.restart
          }
        },
        _Awesome.beautiful.awesomewm
      },
      { "" },
      {
        "Browser",
        _Awesome.applications.browser--_Awesome.applications.browser
          .. ' https://duckduckgo.com/',
        _Awesome.beautiful.browser,
      },
      {
        "Terminal",
        _Awesome.applications.terminal, --_Awesome.userConfig.terminal.command,
        _Awesome.beautiful.console,
      },
      {
         "IM Client",
         _Awesome.applications.im, --_Awesome.userConfig.imclient.command,
         _Awesome.beautiful.im
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
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz"',
                nil,
              },
              {
                "Metal",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/metal"',
                nil,
              },
              {
                "Alternative",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/alternative"',
                nil,
              },
              {
                "Blues",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/blues"',
                nil,
              },
              {
                "SKA",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/ska"',
                nil,
              },
              {
                "Estrada",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/estrada"',
                nil,
              },
              {
                "Shanson",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/shanson"',
                nil,
              },
              {
                "Country",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/country"',
                nil,
              },
              {
                "Children",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/children"',
                nil,
              },
              {
                "Electronics",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/electronics"',
                nil,
              },
              {
                "Dubstep",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/dubstep"',
                nil,
              },
              {
                "Industrial",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/industrial"',
                nil,
              },
              {
                "Experimental",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/experimental"',
                nil,
              },
              {
                "Dance",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/dance"',
                nil,
              },
              {
                "House",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/house"',
                nil,
              },
              {
                "Techno",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/techno"',
                nil,
              },
              {
                "Trance",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/trance"',
                nil,
              },
              {
                "DNB",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/dnb"',
                nil,
              },
              {
                "Relax",
                _Awesome.applications.browser
                  .. ' "https://radio.yandex.kz/genre/relax"',
                nil,
              },
            },
            _Awesome.beautiful.radio_yandex
          },
          {
            "Yandex.Music",
            _Awesome.applications.browser
              .. ' "https://music.yandex.kz"',
            _Awesome.beautiful.music_yandex,
          },
          {
            "101",
            _Awesome.applications.browser
              .. ' "https://101.ru"',
            _Awesome.beautiful.ru101,
          },
          {
            "DI",
            _Awesome.applications.browser
              .. ' "https://di.fm"',
            _Awesome.beautiful.di,
          },
        },
        _Awesome.beautiful.music
      },
      { "", },
      {
        "Applications",
        menugen.build_menu(),
        _Awesome.beautiful.applications
      },
      {
        "Google Applications",
        {
          {
            "Create spreadsheet",
            _Awesome.applications.browser
              .. ' "https://docs.google.com/spreadsheet/ccc?new"',
            _Awesome.beautiful.play_sheets
          },
          {
            "Create document",
            _Awesome.applications.browser
              .. ' "https://docs.google.com/document/create"',
            _Awesome.beautiful.play_docs
          },
          {
            "Create presentation",
            _Awesome.applications.browser
              .. ' "https://docs.google.com/presentation/create"',
            _Awesome.beautiful.play_slides
          },
          {
            "Create draw",
            _Awesome.applications.browser
              .. ' "https://docs.google.com/drawings/create?usp=drive_web"',
            _Awesome.beautiful.play_drawings
          },
          {
            "Create form",
            _Awesome.applications.browser
              .. ' "https://docs.google.com/forms/create"',
            _Awesome.beautiful.play_forms
          },
          { "", },
          {
            "Google Sheets",
            _Awesome.applications.browser
              .. ' "https://docs.google.com/spreadsheets/u/0/"',
            _Awesome.beautiful.play_sheets
          },
          {
            "Google Docs",
            _Awesome.applications.browser
              .. ' "https://docs.google.com/document/u/0/"',
            _Awesome.beautiful.play_docs
          },
          {
            "Google Disk",
            _Awesome.applications.browser
              .. ' "https://drive.google.com/drive/u/0/"',
            _Awesome.beautiful.play_drive
          },
          {
            "Google Hangouts",
            _Awesome.applications.browser
              .. ' "https://hangouts.google.com/"',
            _Awesome.beautiful.play_hangouts
          },
          {
            "Google Calendar",
            _Awesome.applications.browser
              .. ' "https://calendar.google.com/calendar/"',
            _Awesome.beautiful.play_calendar
          },
          {
            "Google Contacts",
            _Awesome.applications.browser
              .. ' "https://contacts.google.com/u/0/preview/all"',
            _Awesome.beautiful.play_contacts
          },
          {
            "Google Books",
            _Awesome.applications.browser
              .. ' "https://play.google.com/books?source=gbs_lp_bookshelf_list"',
            _Awesome.beautiful.play_books
          },
          {
            "Google News",
            _Awesome.applications.browser
              .. ' "https://news.google.com/nwshp?hl=ru"',
            _Awesome.beautiful.play_news
          },
          {
            "Google Inbox",
            _Awesome.applications.browser
              .. ' "https://inbox.google.com/u/0/"',
            _Awesome.beautiful.play_inbox
          }
        },
        _Awesome.beautiful.google_apps
      },
      {
        "Develop",
        {
          {
            "AwesomeWM ApiDoc",
            _Awesome.applications.browser
              .. "http://new.awesomewm.org/apidoc/"
          },
          {
            "Lua Functions",
            {
              {
                "5.1",
                _Awesome.applications.browser
                  .. ' "http://www.lua.org/manual/5.1/index.html#index"'
              },
              {
                "5.2",
                _Awesome.applications.browser
                  .. ' "http://www.lua.org/manual/5.2/index.html#index"'
              },
              {
                "5.3",
                _Awesome.applications.browser
                  .. ' "http://www.lua.org/manual/5.3/index.html#index"'
              }
            },
            _Awesome.beautiful.lualogo
          },
          {
            "A curated list of quality Lua packages and resources",
            _Awesome.applications.browser
              .. ' "https://github.com/LewisJEllis/awesome-lua"',
            _Awesome.beautiful.lualogo
          },
          {
            "Cloud9",
            _Awesome.applications.browser
              .. ' "https://ide.c9.io/"',
            _Awesome.beautiful.cloud9
          }
        },
        _Awesome.beautiful.develop
      },
      { "", },
      {
           "Backup configuration",
	   awesome.restart,
      },
      {
            "Restart",
            'systemctl restart -i',
            _Awesome.beautiful.restart
      },
      {
            "Poweroff",
            'systemctl poweroff -i',
            _Awesome.beautiful.poweroff
      },
    }
  )
  mylauncher = _Awesome.awful.widget.launcher(
    {
      icon = _Awesome.beautiful.awesome_icon,
      menu = mymainmenu
    }
  )
  return mymainmenu, mylauncher
end
-- }}}
