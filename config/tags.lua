local awful = require('awful')
local tyrannical = require("tyrannical")
tyrannical.tags = {
    {
      name = "term",
      init        = false,                   -- Load the tag on startup
      exclusive   = true,                   -- Refuse any other type of clients (by classes)
      screen = {1,2},
      selected    = true,
      layout      = awful.layout.suit.fair,
      class       = { --Accept the following classes, refuse everything else (because of "exclusive=true")
        "xterm" , "urxvt" , "aterm","XTerm","XTerm","konsole","terminator","gnome-terminal"
      }
    },
    {
      name = "net",
      init        = false,                   -- Load the tag on startup
      exclusive   = true,                   -- Refuse any other type of clients (by classes)
      screen = screen.count() > 1 and 2 or 1,
      layout = awful.layout.suit.max,
      class = {
        "Firefox", "Chromium", "nightly", "uzbl", "surf"
      }
    },
    {
      name = "dev",
      init        = false,                   -- Load the tag on startup
      exclusive   = true,                   -- Refuse any other type of clients (by classes)
      screen = screen.count()>2 and 3 or 1,
      layout = awful.layout.suit.max,
      class = {
        "Subl3", "Sublime-Text", "GVim", "Medit", "Gedit", "Geany", "Subl`1" 
      }
    },
    {
      name = "im",
      init        = false,                   -- Load the tag on startup
      exclusive   = true,                   -- Refuse any other type of clients (by classes)
      screen = 1,
      layout = awful.layout.suit.max,
      class = {
        "Psi", "psi", "skype", "xchat", "choqok", "hotot", "qwit"
      }
    },
    {
      name = "music",
      init        = false,                   -- Load the tag on startup
      exclusive   = true,                   -- Refuse any other type of clients (by classes)
      screen = screen.count()>2 and 3 or 1,
      layout = awful.layout.suit.max,
      class = {
        "gmusicbrowser", "mpd", "mpc", "rhythmbox", "amarok"
      }
    },
    {
      name = "vm",
      init        = false,                   -- Load the tag on startup
      exclusive   = true,                   -- Refuse any other type of clients (by classes)
      screen = screen.count()>2 and 3 or 1,
      layout = awful.layout.suit.max,
      class = {
        "VirtualBox", "Qemu"
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

tyrannical.properties.intrusive = {
    "ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"           ,
    "feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color",
    "kcolorchooser" , "plasmoidviewer" , "plasmaengineexplorer" , "Xephyr" , "kruler"     ,
    "yakuake"       ,
    "sflphone-client-kde", "sflphone-client-gnome", "xev",
}
tyrannical.properties.floating = {
    "MPlayer"      , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
    "xine"         , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
    "yakuake"      , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
    "New Form"     , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer" ,
    "sflphone-client-kde", "sflphone-client-gnome", "xev",
    amarok = false , "yakuake", "Conky"
}

tyrannical.properties.ontop = {
    "Xephyr"       , "ksnapshot"       , "kruler"
}

tyrannical.properties.focusable = {
    conky=false
}


tyrannical.properties.no_autofocus = {
    "Conky"
}

tyrannical.properties.below = {
    "Conky"
}

tyrannical.properties.maximize = {
    amarok = false,
}

-- tyrannical.properties.border_width = {
--     XTerm = 0
-- }

tyrannical.properties.border_color = {
    XTerm = "#0A1535"
}

tyrannical.properties.intrusive_popup = {
    "qbittorrent"
}

tyrannical.properties.centered = { "kcalc" }

tyrannical.properties.skip_taskbar = {"yakuake"}
tyrannical.properties.hidden = {"yakuake"}

-- tyrannical.properties.no_autofocus = {"umbrello"}

tyrannical.properties.size_hints_honor = { xterm = false, XTerm = false, aterm = false, sauer_client = false, mythfrontend  = false}