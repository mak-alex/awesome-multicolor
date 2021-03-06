---- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
local awful = require('awful')

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier
}

local tyrannical = require("core.modules.tyrannical")
tyrannical.tags = {
  {
    name        = "term",
    init        = true,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = {1,2},
    selected    = true,
    layout      = awful.layout.suit.floating,
    class       = { --Accept the following classes, refuse everything else (because of "exclusive=true")
      "xterm" , "urxvt" , "aterm","XTerm","XTerm","konsole","terminator","gnome-terminal",
    },
  },
  {
    name        = "net",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = screen.count() > 1 and 2 or 1,
    layout      = awful.layout.suit.tile.left,
    class = {
      "Iceweasel", "Chromium", "nightly", "uzbl", "surf", "Firefox", "luakit", "dwb"
    }
  },
  {
    name        = "photographer",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = screen.count() > 1 and 2 or 1,
    layout      = awful.layout.suit.fair,
    class = {
      "Darktable", "darktable","nomacs","gthumb","Shotwell"
    }
  },
  {
    name        = "dev",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = screen.count()>2 and 3 or 1,
    layout      = awful.layout.suit.tile.left,
    class = {
      "Subl3", "Sublime-Text", "GVim", "Medit", "Gedit", "Geany", "Emacs", "sublime_text", "subl*", "Atom", "Brackets", "Eclipse",
    },
    instance = {
      "vim","*vim*","VIM","*VIM*"
    }
  },
  {
    name        = "games",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = 1,
    layout      = awful.layout.suit.fair,
    class = {
      "Steam", "steam", "steam-launcher", "Steam-Launcher"
    }
  },
  {
    name        = "im",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = 1,
    layout      = awful.layout.suit.max,
    class = {
      "Psi", "psi", "skype", "xchat", "choqok", "hotot", "qwit",
    },
    instance = {
      "weechat", "mcabber", "irssi", "profanity"
    }
  },
  {
    name        = "mail",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = 1,
    layout      = awful.layout.suit.max,
    instance    = { "mutt" },
    class = {
      "Thunderbird",
    }
  },

  {
    name        = "music",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = screen.count()>2 and 3 or 1,
    layout      = awful.layout.suit.max,
    class = {
      "gmusicbrowser", "rhythmbox", "amarok"
    }
  },
  {
    name        = "files",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = screen.count()>2 and 3 or 1,
    layout      = awful.layout.suit.max,
    class = {
      "SpaceFM",
    },
    instance = {
      "ranger","*ranger*"
    }
  },
  {
    name        = "downloads",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = screen.count()>2 and 3 or 1,
    layout      = awful.layout.suit.max,
    class = {
      "transmission-gtk", "deluge", "qtbittorrent", "Qbittorrent"
    },
    intance = {
       "rtorrent"
    }
  },
  {
    name        = "vm",
    init        = false,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = screen.count()>2 and 3 or 1,
    layout      = awful.layout.suit.max,
    class = {
      "VirtualBox", "Qemu", "Virt-manager",
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

tyrannical.properties.intrusive        = {
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
  "Xephyr"       , "ksnapshot"       , "kruler", "urxvt"
}

tyrannical.properties.focusable = {
  conky = false
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

tyrannical.properties.border_width = {
   urxvt = 3
}

--[[tyrannical.properties.border_color = {
  urxvt = "#7788af"
}]]

tyrannical.properties.intrusive_popup = {
  "qbittorrent"
}

tyrannical.properties.centered = {
  "kcalc", "urxvt"
}

tyrannical.properties.skip_taskbar = {
  "yakuake"
}
tyrannical.properties.hidden = {
  "yakuake"
}

-- tyrannical.properties.no_autofocus = {"umbrello"}

tyrannical.properties.size_hints_honor = {
  xterm = false,
  XTerm = false,
  aterm = false,
  sauer_client = false,
  mythfrontend  = false
}
