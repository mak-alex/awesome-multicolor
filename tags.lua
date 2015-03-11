local awful = require('awful')
local tyrannical = require("tyrannical")
tyrannical.tags = {
    {
      name = "term",
      init = false,
      exclusive = true,
      screen = {1,2},
      layout      = awful.layout.suit.fair,
      class       = { --Accept the following classes, refuse everything else (because of "exclusive=true")
        "xterm" , "urxvt" , "aterm","URxvt","XTerm","konsole","terminator","gnome-terminal"
      }
    },
    {
      name = "net",
      init = false,
      exclusive = true,
      screen = screen.count() > 1 and 2 or 1,
      layout = awful.layout.suit.max,
      class = {
        "Firefox", "Chromium", "nightly", "uzbl", "surf"
      }
    },
    {
      name = "im",
      init = false,
      exclusive = true,
      screen = 1,
      layout = awful.layout.suit.max,
      class = {
        "Psi", "psi", "skype", "xchat", "choqok", "hotot", "qwit"
      }
    },
    {
      name = "mus",
      init = false,
      exclusive = true,
      screen = screen.count()>2 and 3 or 1,
      layout = awful.layout.suit.max,
      class = {
        "gmusicbrowser", "mpd", "mpc", "rhythmbox", "amarok"
      }
    },
    {
      name = "vm",
      init = false,
      exclusive = true,
      screen = screen.count()>2 and 3 or 1,
      layout = awful.layout.suit.max,
      class = {
        "VirtualBox", "Qemu"
      }
    },
    {
      name = "dev",
      init = false,
      exclusive = true,
      screen = screen.count()>2 and 3 or 1,
      layout = awful.layout.suit.max,
      class = {
        "Subl3", "Sublime-Text", "GVim", "Medit", "Gedit", "Geany", 
      }
    },
    {
        name        = "doc",
        init        = false, -- This tag wont be created at startup, but will be when one of the
                             -- client in the "class" section will start. It will be created on
                             -- the client startup screen
        exclusive   = true,
        layout      = awful.layout.suit.max,
        class       = {
            "Assistant"     , "Okular"         , "Evince"    , "EPDFviewer"   , "xpdf",
            "Xpdf"          ,                                        }
    } ,
}
-- todo: video for vlc and virtualbox for VBox

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
  "MPlayer"      , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
  "xine"         , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
  "yakuake"      , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
  "New Form"     , "Insert Picture"  , "kcharselect", "Xephyr" , "plasmoidviewer" 
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
  "Xephyr"       , "ksnapshot"       , "kruler"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
      "kcalc"
}

tyrannical.settings.block_children_focus_stealing = true --Block popups ()
tyrannical.settings.group_children = true --Force popups/dialogs to have the same tags as the parent client
