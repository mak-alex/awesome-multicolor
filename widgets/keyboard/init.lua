layout_indicator = require("modules.keyboard-layout-indicator.keyboard-layout-indicator")
-- define your layouts
kbdcfg = layout_indicator({
    layouts = {
        {name="dv",  layout="de",  variant="dvorak"},
        {name="ru",  layout="ru",  variant="winkeys"},
        {name="us",  layout="us",  variant=nil}
    }
})

-- optionally add a middle-mouse binding to set a custom layout:
kbdcfg.widget:buttons(awful.util.table.join(
    kbdcfg.widget:buttons(),
    awful.button({ }, 2, 
        function ()
            awful.prompt.run(
                { prompt="Run: ", text="setxkbmap " },
                mypromptbox[mouse.screen].widget,
                function(cmd) kbdcfg:setcustom(cmd) end )
        end)
))
