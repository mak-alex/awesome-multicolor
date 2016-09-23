_Awesome.awful.layout.layouts = {
  _Awesome.awful.layout.suit.floating,
  _Awesome.awful.layout.suit.tile,
  _Awesome.awful.layout.suit.tile.left,
  _Awesome.awful.layout.suit.tile.bottom,
  _Awesome.awful.layout.suit.tile.top,
  _Awesome.awful.layout.suit.fair,
  _Awesome.awful.layout.suit.fair.horizontal,
  _Awesome.awful.layout.suit.spiral,
  _Awesome.awful.layout.suit.spiral.dwindle,
  _Awesome.awful.layout.suit.max,
  _Awesome.awful.layout.suit.max.fullscreen,
  _Awesome.awful.layout.suit.magnifier
}
-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count()
do
  -- Each screen has its own tag table.
  tags[s] = _Awesome.awful.tag(
    --[[{
    Variable:
      "♨", "⌨", "⚡", "✉", "☕", "❁", "☃", "☄", "⚢"
      "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒"
      "☠", "⌥", "✇", "⌤", "⍜", "✣", "⌨", "⌘", "☕"

    },]]
    {
      "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒"
    },
    s,
    _Awesome.awful.layout.suit.fair.horizontal
  );
end
-- }}}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9
do
  globalkeys = _Awesome.awful.util.table.join(
    globalkeys,
    -- View tag only.
    _Awesome.awful.key(
      {
        "Mod4"--userConfig.modkey
      },
      "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = _Awesome.awful.tag.gettags(screen)[i]

        if tag
        then
           _Awesome.awful.tag.viewonly(tag)
        end
      end
    ),
    -- Toggle tag.
    _Awesome.awful.key(
      {
        "Mod4", --userConfig.modkey,
        "Control"
      },
      "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = _Awesome.awful.tag.gettags(screen)[i]

        if tag
        then
           _Awesome.awful.tag.viewtoggle(tag)
        end
      end
    ),
    -- Move client to tag.
    _Awesome.awful.key(
      {
        "Mod4", --userConfig.modkey,
        "Shift"
      },
      "#" .. i + 9,
      function ()
        if client.focus
        then
          local tag = _Awesome.awful.tag.gettags(client.focus.screen)[i]

          if tag
          then
            _Awesome.awful.client.movetotag(tag)
          end
        end
      end
    ),
    -- Toggle tag.
    _Awesome.awful.key(
      {
        "Mod4", --userConfig.modkey,
        "Control",
        "Shift"
      },
      "#" .. i + 9,
      function ()
        if client.focus
        then
          local tag = _Awesome.awful.tag.gettags(client.focus.screen)[i]

          if tag
          then
            _Awesome.awful.client.toggletag(tag)
          end
        end
      end
    )
  )
end
