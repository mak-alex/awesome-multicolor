---- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count()
do
  -- Each screen has its own tag table.
  tags[s] = awful.tag(
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
    awful.layout.suit.fair.horizontal
  );
end
-- }}}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9
do
  globalkeys = awful.util.table.join(
    globalkeys,
    -- View tag only.
    awful.key(
      {
        modkey
      },
      "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]

        if tag
        then
           awful.tag.viewonly(tag)
        end
      end
    ),
    -- Toggle tag.
    awful.key(
      {
        modkey,
        "Control"
      },
      "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]

        if tag
        then
           awful.tag.viewtoggle(tag)
        end
      end
    ),
    -- Move client to tag.
    awful.key(
      {
        modkey,
        "Shift"
      },
      "#" .. i + 9,
      function ()
        if client.focus
        then
          local tag = awful.tag.gettags(client.focus.screen)[i]

          if tag
          then
            awful.client.movetotag(tag)
          end
        end
      end
    ),
    -- Toggle tag.
    awful.key(
      {
        modkey,
        "Control",
        "Shift"
      },
      "#" .. i + 9,
      function ()
        if client.focus
        then
          local tag = awful.tag.gettags(client.focus.screen)[i]

          if tag
          then
            awful.client.toggletag(tag)
          end
        end
      end
    )
  )
end
