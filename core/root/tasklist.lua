-- {{{ Task list
mytasklist = {}
mytasklist.buttons = _Awesome.awful.util.table.join(
  _Awesome.awful.button(
    { },
    1,
    function (c)
      if c == client.focus
      then
        c.minimized = true
      else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible()
        then
          _Awesome.awful.tag.viewonly(c:tags()[1])
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
      end
    end
  ),
  _Awesome.awful.button(
    { },
    3,
    function ()
      if instance
      then
        instance:hide()
        instance = nil
      else
        instance = _Awesome.awful.menu.clients(
          {
            theme = {
              width = 250
            }
          }
        )
      end
    end
  ),
  _Awesome.awful.button(
    { },
    4,
    function ()
      _Awesome.awful.client.focus.byidx(1)
      if client.focus
      then
        client.focus:raise()
      end
    end
  ),
  _Awesome.awful.button(
    { },
    5,
    function ()
      _Awesome.awful.client.focus.byidx(-1)
      if client.focus
      then
        client.focus:raise()
      end
    end
  )
)
-- }}}
