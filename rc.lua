-- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
local Awesome = {
  _NAME = "MultiColor",
  _VERSION = 'MULTICOLOR v1.0',
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
  Multicolor Configuration for the awesome window manager (3.5)
    If you're disappointed by fonts, check your `~/.fonts.conf`.
    It is presumed that you configure your autostart in `~/.xinitrc`.

    ##Capabilities
      * Themes
      * Dynamic wallpaper
      * Test script for hacking
      * Dynamic desktop tagging (via tyrannical)
      * ALSA control (by Rman)
      * Freedesktop menu
      * Multiple desktop support
      * Beautiful notifications (via naughty)
  ]]
}
json = require'core.lib.json'

local mt = { __index = Awesome }
-- Метод инициализации инстанса,
-- другими словами это очень большая конфигурация
-- @params _settings - table
-- @return response - metatable
function Awesome:new(_settings)
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  -- ==========================================================
  -- подключаем библиотеки и сторонние модули
  -- ==========================================================
  instance.awful = require'awful'
  instance.awful.autofocus = require("awful.autofocus")
  instance.awful.rules = require("awful.rules")
  -- библиотека для работы с виджетами и их конструирования
  instance.wibox = require("wibox")
  instance.gears = require('gears')
  -- библиотека позволяющая модифировать оформление AwesomeWM
  instance.beautiful = require("beautiful")
  -- библиотека реализующая всплывающие уведомления
  instance.naughty = require("naughty")
  instance.lfs = require'lfs'
  -- модуль для работы с динамическими тегами
  instance.lain = require'core/modules/lain'
  -- ==========================================================
  instance._wibox = {}

  -- Получаем полный путь до директории awesome
  instance.config = instance.awful.util.getdir'config'


  function isempty(s)
    return s == nil or (type(s) == "table" and next(s)==nil) or s == ''
  end

  instance.String2File = function(filename, data, verbose)
    if filename and data ~= nil
    then
      local path = filename
      file = assert(io.open(path, "w"))
      io.output(file)
      io.write(json:encode_pretty(data), "\n")
      io.close(file)
      print('done write config')
      return 0
    else
      print('fack don\'t write config')
      --log.warning("not open file to write", verbose)
      return 1
    end
  end

  instance.File2String = function(filename, verbose)
    if not isempty(filename)
    then
      local jsonConfigFile = assert(io.open(filename, "r"))
      local stringFile = jsonConfigFile:read "*a"
      jsonConfigFile:close()
      --log.info("Convert file "..filename.." to string - done", verbose)
      return stringFile
    else
      --log.warning("not open file", self.verbose)
      return 1
    end
  end

  instance._settings = json:decode(instance.File2String(instance.config .. '/config.json'))


  -- после каждого изменения и удачного старта
  -- делать копию конфигурации на случае неудачных попыток
  -- в дальнейшем
  instance.backupFile = instance._settings.switches.system.backup
  -- оформление по-умолчанию
  instance.themename = instance._settings.themes
  -- ==========================================================
  -- Управлением панелями, модулями и виджетами
  instance.switches = instance._settings.switches
  -- ==========================================================

  -- Если в true,
  if instance.switches.system.tags
  then
    -- подгружаем модуль для динамического формирования тегов
    instance.tyrannical = require'core.modules.tyrannical'
    -- также подгружаем сам модуль формирования тегов,
    -- на основе статических правил
    instance.tags = require'core.root.tags'
  end

  -- Если в true, подгружаем модуль для работы с MPD сервером
  if instance.switches.system.mpd
  then
    -- модуль для работы с MPD сервером
    instance.mpd = require'core.modules.awesompd'
  end

  -- ==========================================================
  -- Пути по-умолчанию
  instance.path = {
    -- путь до директории с оформлениями
    themes = instance.config .. '/themes/',
    -- путь до системной директории
    core = instance.config .. '/core',
    -- путь до системных файлов
    root = instance.config .. '/core/root',
    -- путь до директории с плагинами
    plugins = instance.config .. '/core/plugins',
    -- путь до директории с модулями
    modules = instance.config .. '/core/modules'
  }
  -- ==========================================================

  -- ==========================================================
  -- список обязательных системных файлов,
  instance.files = {
    -- файл конфигурации AwesomeMinimal
    awesome = instance.path.root .. '/awesome.lua',
    -- файл резервной конфигурации AwesomeMinimal
    backupAwesome = instance.path.root .. '/.awesome.lua',
    -- файл конфигурирующий хоткеи для AwesomeWM
    bindings = instance.path.root .. '/bindings.lua',
    -- файл конфигурирующий поведение тегов (автомат)
    tags = instance.path.root .. '/tags.lua',
    -- файл конфигурирующий поведение тегов (ручной)
    tags_fallback = instance.path.root .. '/tags_fallback.lua',
    tasklist = instance.path.root .. '/tasklist.lua',
    userConfiguration = instance.path.root .. '/userConfiguration',
  }
  -- ==========================================================

  instance.modkey = instance._settings.keys.modkey
  instance.altkey = instance._settings.keys.altkey

  -- ==========================================================
  -- список приложений по-умолчанию,
  -- опционально меняется при инициализации инстанса
  instance.applications = instance._settings.applications
  -- ==========================================================

  -- ==========================================================
  -- внутре-системные переменные для различных проверок
  instance.variables = instance._settings.variables
  -- ==========================================================

  -- ==========================================================
  -- вспомогательные методы (доступны только в пределах данного инстанса)
  -- Методы для уведомления пользователя,
  -- о тех или иных событиях
  instance.notify = {
    -- детальный вывод ошибки при падении из-за правок
    -- в коде со стороны невнимательного пользователя
    -- @params _errmessage - string
    errors = function(_errmessage)
      -- если тип аргумента не строковый
      if type(_errmessage) ~= 'string'
      then
        -- вместо ошибки отдаем тип входящего аргумента
        _errmessage = type(_errmessage)
      end

      instance.naughty.notify {
        text =
          "BACKUP: "
          .."Restore Multicolor Configuration from Awesome 3.5\n"
          .. '\nNAME: MultiColor'
          .. '\nVER.: '.."3.0"
          .. '\nURL: '.. 'https://bitbucket.org/enlab/multicolor'
          .. '\nPATH: ' .. instance.files.backupAwesome
          .. '\nERROR: ' .. _errmessage
          .. '\n\nPlease try to fix the error in'
          .. 'the main configuration file and restart Awesome!'
          .. '\nIf you can not fix the error yourself,'
          .. ' contact the developer!\n'
          .. '\n\nCoded by Alexandr Mikhailenko '
          .. 'a.k.a. Alex M.A.K. '
          ..'<alex-m.a.k@yandex.kz>'
          ..'\n',
        ontop = true,
        border_color = "#7788af",
        border_width = 3,
        timeout = 60,
        position   = "top_right"
      }
    end,
    -- детальный вывод любой информации,
    -- как пример используется для вывода информации
    -- MPD сервера
    -- @params _title - string
    -- @params _message - string
    -- @params _timeout - number
    message = function(_title, _message, _timeout)
      instance.naughty.notify {
        title = _title or "NaN",
        text = _message or "NaN",
        ontop = true,
        border_color = "#7788af",
        border_width = 3,
        timeout = _timeout or 5,
        position   = "top_right"
      }
   end
  }
  -- ==========================================================

  -- ==========================================================
  -- вспомогательные утили, копирование, проверки и т.д.
  instance.utils = {
    -- Метод для проверки существования директории
    -- @param path - string
    -- @return bool
    FolderExists = function(_path)
      if instance.lfs.attributes(_path:gsub('\\$', ''), 'mode') == 'directory'
      then
        return true
      end
      return false
    end,
    -- Чтение файла
    -- @param path - string
    -- @param mode - string
    -- @return bool
    fileRead = function(path, mode)
      mode = mode or '*a'
      local file, err = io.open(path, 'rb')
      if err then error(err) end
      local content = file:read(mode)
      file:close()
      return content
    end,
    -- Запись в файл
    -- @param path - string
    -- @param content - string
    -- @param mode - string
    -- @return bool
    fileWrite = function(path, content, mode)
      mode = mode or 'w'
      local file, err = io.open(path, mode)
      if err then error(err) end
      file:write(content)
      file:close()
    end,
    -- метод для проверки существования файла
    -- @param path - string
    -- @return bool
    FileExists = function(_path)
      if instance.lfs.attributes(_path:gsub('\\$', ''), 'mode') == 'file'
      then
        return true
      end
      return false
    end,
    -- метод для копирования файла
    -- @params src - string
    -- @params dest - string
    FileCopy = function(src, dest)
      local content = instance.utils.fileRead(src)
      if content
      then
        instance.utils.fileWrite(dest, content)
        if instance.utils.FileExists(dest)
        then
          instance.notify.message(
            'Backup:',
            'Copying the backup configuration, status: true, file: '
              .. dest
          )
        else
          instance.notify.message(
            'Backup:',
            'Copying the backup configuration, status: false'
          )
        end
      else
        instance.notify.message(
          'Backup:',
          'Could not open source: ' .. src
        )
      end
    end
  }
  -- ==========================================================

  -- для хранения подгружаемой конфигурации
  instance.awesome = nil

  return instance
end

-- Метод для проверки существования системных директорий
-- @params force - bool
-- @return self.variables.checkConfigurations - bool
function Awesome:CheckDirConfigurations(force)
  -- если передан true,
  if force
  then
    -- запускаем принудительную проверку
    self.variables.checkDirConfigurations = true
  end

  --- Проверяем существования системных директорий
  if self.variables.checkDirConfigurations
  then
    -- Список директорий для проверки
    local ConfigurationsDir = {
      self.path.usedThemes,
      self.path.modules,
      self.path.plugins
    }

    -- Перебираем директории
    for i=1, #ConfigurationsDir
    do
      -- Если одна из системных директорий отсутствует,
      if not self.utils.FolderExists(ConfigurationsDir[i])
      then
        -- создаем ее, в противном случае ничего не делаем
        self.awful.util.mkdir(ConfigurationsDir[i])
      end
    end

    -- Помечаем проверку выполненной
    self.variables.checkDirConfigurations = false
  end
end

function Awesome:CheckConfigurations(force)
  -- если передан true,
  if force
  then
    -- запускаем принудительную проверку
    self.variables.checkFileConfigurations = true
  end

  local ConfigurationsFile = {
  }

  -- Перебираем файлы
  for i=1, #ConfigurationsDir
  do
    -- Если один из системных файлов отсутствует,
    if not self.utils.FileExists(ConfigurationsFile[i])
    then
      -- скачиваем и складываем в соответствующем порядке,
      -- в противном случае ничего не делаем
      --awful.util.mkdir(ConfigurationsFile[i])
    end
  end

  -- Помечаем проверку файлов выполненной
  self.variables.checkFileConfigurations = false
end

function Awesome:StatMPD()
  local mpdStatus = self.mpd:status()
  local mpdStats = self.mpd:stats()
  local currentSong = self.mpd:currentsong()
  -- выводим сообщем о успешном результате
  self.notify.message(
    'Information:',
      'Current track:' .. currentSong.file
      .. '\n\nCurrent settings MPD:'
      .. '\n * Volume: ' .. mpdStatus.volume
      .. '\n * State: ' .. mpdStatus.state
      .. '\n * Playlists: ' .. mpdStatus.playlist
      .. '\n * Albums: ' .. mpdStats.albums,
    20
  )
end
function Awesome:InitMPD()
  -- инициализируем модуль
  self.mpd = self.mpd.new(
    {
      hostname = _Awesome.variables.mpd.settings.hostname,
      port = _Awesome.variables.mpd.settings.port,
      desc = _Awesome.variables.mpd.settings.desc,
      password = _Awesome.variables.mpd.settings.password,
      timeout = _Awesome.variables.mpd.settings.timeout,
      retry = _Awesome.variables.mpd.settings.retry
    }
  )
  local mpdStatus = self.mpd:status()
  local mpdStats = self.mpd:stats()
  if mpdStats == nil or mpdStats == "" 
  then 
    self.switches.system.mpd = false 
    self.notify.message(
      'Initialization module:',
      'Initialization MPD module, status: false'
        .. '\n\nTry, service mpd start',
      20
    )
    return nil
  end
  local currentSong = self.mpd:currentsong()
  _Awesome.variables.mpd.status.state = mpdStatus.state
  _Awesome.variables.mpd.status.track = currentSong.file
  _Awesome.variables.mpd.status.volume = mpdStatus.volume
  -- если модуль успешно подгружен и авторизован
  if self.mpd and not mpdStatus.errormsg
  then
    -- выводим сообщем о успешном результате
    self.notify.message(
      'Initialization module:',
      'Initialization MPD module, status: true'
        .. '\n\nCurrent settings MPD:'
        .. '\n * Volume: ' .. mpdStatus.volume
        .. '\n * State: ' .. mpdStatus.state
        .. '\n * Playlists: ' .. mpdStatus.playlist
        .. '\n * Albums: ' .. mpdStats.albums,
      20
    )
  else
    -- выводим в случае ошибки
    self.notify.message(
      'Initialization module:',
      'Initialization MPD module, status: false\n\n'
        .. 'Possible causes:\n'
        .. '* not correctly specified IP address and/or port\n'
        .. '* not correct the login and/or password\n'
        .. '* missing library "luasocket"',
      10
    )
  end
end

function Awesome:ConfigurationUp(force)
  -- если в true,
  if self.switches.system.mpd
  then
    self:InitMPD()
  end
  -- грузим конфигурацию
  self.awesome, err  = loadfile(self.files.awesome);

  -- если конфигурация загружена
  if self.awesome
  then
    -- проверяем успешность загрузки,
    -- запускаем конфигурацию
    self.awesome, err = pcall(self.awesome);
    -- если конфигруцая загружена успешно
    if self.awesome
    then
      -- создаем резервную копию,
      -- на случай если основная рухнет
      -- по ошибки пользователя
      if self.backupFile or force
      then
        self.utils.FileCopy(
          self.files.awesome,
          self.files.backupAwesome
        )
        self.backupFile = false
      end
    else
      -- загружаем резервную копию,
      -- видимо что-то пошло не так
      self.awesome, _err = loadfile(self.files.backupAwesome)
      -- Запускаем резервную копию
      self.awesome, _err = pcall(self.awesome);
      if err or _err
      then
        self.notify.errors(err or _err)
      end
    end
  end
end

function main()
  do
    _Awesome = Awesome:new()
    _Awesome:CheckDirConfigurations()
    _Awesome:ConfigurationUp()
  end
end
main()
