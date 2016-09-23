-- импорт оформлений для Awesom'a
require'themes'

-- правила хоткеев
require'core/root/bindings'

-- импорт основных виджетов
require'core/widgets'

-- разделители и прочие элементы оформления
require'core/behavior/separators'

-- по-умолчанию используем обычный вариант тегов
if not _Awesome.switches.system.dynamic_tags
then
  require("core.root.tags_fallback")
end

-- генерируем основное меню на основе бла-бла-бла ;-)
local mymainmenu, mylauncher = generateMenu()

-- {{{ дополнительная проверка
-- do
--   local in_error = false
--   awesome.connect_signal(
--     "debug::error",
--     function (err)
--       -- если есть ошибка
--       if in_error
--       then
--         return
--       end

--       -- включаем вывод
--       in_error = true
--       -- выводим подробную/известную информацию
--       _Awesome.notify.errors(err)
--       -- выключаем вывод
--       in_error = false
--     end
--   )
-- end
-- }}}

require'core/root/tasklist'

-- Java GUI's fix
_Awesome.awful.util.spawn_with_shell("wmname LG3D")


-- {{{ Wibox initialisation
local wibox = {}
wibox.top = {}
wibox.bottom = {}
wibox.tag = {}
mypromptbox = {}
local mylayoutbox = {}
local _tagList = {}
_tagList.buttons = _Awesome.awful.util.table.join(
  _Awesome.awful.button(
    { },
    1,
    _Awesome.awful.tag.viewonly
  ),
  _Awesome.awful.button(
    { modkey },
    1,
    _Awesome.awful.client.movetotag
  ),
  _Awesome.awful.button(
    { },
    3,
    _Awesome.awful.tag.viewtoggle
  ),
  _Awesome.awful.button(
    { modkey },
    3,
    _Awesome.awful.client.toggletag
  ),
  _Awesome.awful.button(
    { },
    4,
    function(t)
      _Awesome.awful.tag.viewnext(_Awesome.awful.tag.getscreen(t))
    end
  ),
  _Awesome.awful.button(
    { },
    5,
    function(t)
      _Awesome.awful.tag.viewprev(_Awesome.awful.tag.getscreen(t))
    end
  )
)

for s = 1, screen.count()
do
  mypromptbox[s] = _Awesome.awful.widget.prompt()
  -- icon indicating which layout we're using
  mylayoutbox[s] = _Awesome.awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(
    _Awesome.awful.util.table.join(
      _Awesome.awful.button(
        { },
        1,
        function ()
          _Awesome.awful.layout.inc(_Awesome.awful.layout.layouts, 1)
        end
      ),
      _Awesome.awful.button(
        { },
        3,
        function ()
          _Awesome.awful.layout.inc(_Awesome.awful.layout.layouts, -1)
        end
      ),
      _Awesome.awful.button(
        { },
        4,
        function ()
          _Awesome.awful.layout.inc(_Awesome.awful.layout.layouts, 1)
        end
      ),
      _Awesome.awful.button(
        { },
        5,
        function ()
          _Awesome.awful.layout.inc(_Awesome.awful.layout.layouts, -1)
        end
      )
    )
  )

  local tagsh = 3
  _tagList[s] = _Awesome.awful.widget.taglist(
    s,
    _Awesome.awful.widget.taglist.filter.all,
    _tagList.buttons
  )
  mytasklist[s] = _Awesome.awful.widget.tasklist(
    s,
    _Awesome.awful.widget.tasklist.filter.currenttags,
    mytasklist.buttons
  )
  if _Awesome.switches.panels.top
  then
    wibox.top[s] = _Awesome.awful.wibox(
      {
        position = "top",
        screen = s,
        border_width = _Awesome.beautiful.border_width,
        height = 22
      }
    )
  end

  -- Widgets that are aligned to the left
  local left_layout = _Awesome.wibox.layout.fixed.horizontal()
  -- Widgets that are aligned to the right
  local right_layout = _Awesome.wibox.layout.fixed.horizontal()
  --- }}}

  left_layout:add(_spr)
  left_layout:add(_tagList[s])
  left_layout:add(mypromptbox[s])
  left_layout:add(_spr)
  if s == 1
  then
    right_layout:add(_Awesome.wibox.widget.systray())
  end

  -- если разрешено отображаем виджеты
  if _Awesome.switches.system.widgets
  then
    right_layout:add(_spr)
    right_layout:add(arrl)
    -- отображаем все виджеты, независимо от того,
    -- включен тот или иной, в том случае если включены две панели
    if _Awesome.switches.panels.top and _Awesome.switches.panels.bottom
    then
      -- если разрешен отображаем
      if _Awesome.switches.widgets.network
      then
        right_layout:add(netdownicon)
        right_layout:add(netdowninfo)
        right_layout:add(netupicon)
        right_layout:add(netupinfo)
      end
      if _Awesome.switches.widgets.volume
      then
        right_layout:add(volicon)
        right_layout:add(volumewidget)
      end
      if _Awesome.switches.widgets.memmory
      then
        right_layout:add(memicon)
        right_layout:add(memwidget)
      end
      if _Awesome.switches.widgets.cpuinfo
      then
        right_layout:add(cpuicon)
        right_layout:add(cpuwidget)
      end
      if _Awesome.switches.widgets.temperature_cpu
      then
        right_layout:add(tempicon)
        right_layout:add(tempwidget)
      end
      if _Awesome.switches.widgets.filesysteminfo
      then
        right_layout:add(fsicon)
        right_layout:add(fswidget)
      end
    end
    -- если нижняя панель отключена
    if not _Awesome.switches.panels.bottom
    then
      right_layout:add(mylayoutbox[s])
    end
  end
  --- }}}

  -- если одна из панелей отключена или отключены виджеты,
  -- отображаем минимум виджетов
  if _Awesome.switches.widgets.battery
  then
    right_layout:add(baticon)
    right_layout:add(batwidget)
  end
  if _Awesome.switches.widgets.clock
  then
    right_layout:add(widget_clock)
    right_layout:add(clockwidget)
  end

  -- Now bring it all together (with the tasklist in the middle)
  if _Awesome.switches.panels.top
  then
    local layout = _Awesome.wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    -- если нижняя панель отключена
    if not _Awesome.switches.panels.bottom
    then
      layout:set_middle(mytasklist[s])
    end
    layout:set_right(right_layout)
    wibox.top[s]:set_widget(layout)
  end

  -- если нижняя панель включена
  if _Awesome.switches.panels.bottom
  then
    -- Create the bottom wibox
    wibox.bottom[s] = _Awesome.awful.wibox(
      {
        position = "bottom",
        screen = s,
        border_width = _Awesome.beautiful.border_width,
        height = 20
      }
    )
    -- Widgets that are aligned to the bottom left
    bottom_left_layout = _Awesome.wibox.layout.fixed.horizontal()

    -- если верхняя панель отключена
    if not _Awesome.switches.panels.top
    then
      bottom_left_layout:add(left_layout)
    end

    -- Widgets that are aligned to the bottom right
    bottom_right_layout = _Awesome.wibox.layout.fixed.horizontal()

    -- если верхняя панель отключена
    if not _Awesome.switches.panels.top
    then
      bottom_right_layout:add(right_layout)
    end
    bottom_right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    bottom_layout = _Awesome.wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_middle(mytasklist[s])
    bottom_layout:set_right(bottom_right_layout)

    wibox.bottom[s]:set_bg(_Awesome.beautiful.bg_normal)
    wibox.bottom[s]:set_widget(bottom_layout)
  end
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
  "manage",
  function (c)
    c:connect_signal(
      "mouse::enter",
      function(c)
        if _Awesome.awful.layout.get(c.screen) ~= _Awesome.awful.layout.suit.magnifier and _Awesome.awful.client.focus.filter(c)
        then
          client.focus = c
        end
      end
    )

    if not startup
    then
      if not c.size_hints.user_position and not c.size_hints.program_position
      then
        _Awesome.awful.placement.no_overlap(c)
        _Awesome.awful.placement.no_offscreen(c)
      end
    end

    if not awesome.startup
    then
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      -- _Awesome.awful.client.setslave(c)
      -- Put windows in a smart way, only if they does not set an initial position.
      if not c.size_hints.user_position and not c.size_hints.program_position
      then
        _Awesome.awful.placement.no_overlap(c)
        _Awesome.awful.placement.no_offscreen(c)
      end
    end
  end
)
-- }}}

-- {{{ Enable sloppy focus
client.connect_signal(
  "mouse::enter",
  function(c)
    if _Awesome.awful.layout.get(c.screen) ~= _Awesome.awful.layout.suit.magnifier and _Awesome.awful.client.focus.filter(c)
    then
      client.focus = c
    end
  end
)

client.connect_signal(
  "focus",
  function(c)
    c.border_color = _Awesome.beautiful.border_focus
  end
)

client.connect_signal(
  "unfocus",
  function(c)
    c.border_color = _Awesome.beautiful.border_normal
  end
)
-- }}}

-- {{{ Default static wall
if _Awesome.beautiful.wallpaper
then
  for s = 1,screen.count()
  do
    _Awesome.gears.wallpaper.maximized(_Awesome.beautiful.wallpaper, s, true)
  end
end
-- }}}
