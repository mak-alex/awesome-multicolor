
                -- [    Pro Light theme for Awesome 3.5.5    ] --
                -- [            author: barwinco             ] --
                -- [    http://github.com/barwinco/pro       ] --


-- // got the idea from Holo theme by Luke Bonham (https://github.com/copycat-killer)

-- patch for taglist: https://github.com/awesomeWM/awesome/pull/39


theme            = {}
theme.icons      = os.getenv("HOME") .. "/.config/awesome/themes/pro-light/icons/"
theme.wallpaper  = os.getenv("HOME") .. "/.config/awesome/themes/pro-light/wallpapers/pro-light-shadow.png"
theme.panel      = "png:" .. theme.icons .. "/panel/panel.png"
theme.font       = "Ohsnap 8"

-- | AWESOME WM | --
theme.awesomewm = theme.icons .. '/awesomewm.png'
theme.lockscreen = theme.icons .. '/lockscreen.png'
theme.browser = theme.icons .. '/browser.png'
theme.console = theme.icons .. '/console.png'
theme.filemanager = theme.icons .. '/filemanager.png'
theme.email = theme.icons .. '/email.png'
theme.awesomeManual = theme.icons .. '/awesomeManual.png'
theme.sourceEdit = theme.icons .. '/sourceEdit.png'
theme.file = theme.icons .. '/file.png'
theme.updateAwesome = theme.icons .. '/updateAwesome.png'
theme.themesAwesome = theme.icons .. '/themesAwesome.png'
theme.poweroff = theme.icons .. '/poweroff.png'
theme.restart = theme.icons .. '/restart.png'
theme.applications = theme.icons .. '/applications.png'
theme.lualogo = theme.icons .. '/luaLogo.png'
theme.cloud9 = theme.icons .. '/cloud9.png'
theme.develop = theme.icons .. '/develop.png'
-- | GOOGLE APPS | --
theme.google_apps = theme.icons .. '/google/google_apps.png'
--
theme.play_books = theme.icons .. '/google/play_book.png'
theme.play_docs = theme.icons .. '/google/play_doc.png'
theme.play_sheets = theme.icons .. '/google/play_sheet.png'
theme.play_forms = theme.icons .. '/google/play_form.png'
theme.play_slides = theme.icons .. '/google/play_slide.png'
theme.play_drawings = theme.icons .. '/google/play_drawing.png'
theme.play_drive = theme.icons .. '/google/play_drive.png'
theme.play_hangouts = theme.icons .. '/google/play_hangouts.png'
theme.play_calendar = theme.icons .. '/google/play_calendar.png'
theme.play_news = theme.icons .. '/google/play_news.png'
theme.play_contacts = theme.icons .. '/google/play_contacts.png'
theme.play_inbox = theme.icons .. '/google/play_inbox.png'

theme.fg_normal  = "#3D3D3D"
theme.fg_focus   = "#333333"
theme.fg_urgent  = "#CC9393"

theme.bg_normal  = "#D6D6D6"
theme.bg_focus   = "#A4A4A4"
theme.bg_urgent  = "#3F3F3F"
theme.bg_systray = "#d6d6d6"

theme.clockgf    = "#000000"

-- | Borders | --

theme.border_width  = 1
theme.border_normal = "#D6D6D6"
theme.border_focus  = "#A4A4A4"
theme.border_marked = "#000000"

-- | Menu | --

theme.menu_height = 16
theme.menu_width  = 160

-- | Layout | --

theme.layout_floating   = theme.icons .. "/panel/layouts/floating.png"
theme.layout_tile       = theme.icons .. "/panel/layouts/tile.png"
theme.layout_tileleft   = theme.icons .. "/panel/layouts/tileleft.png"
theme.layout_tilebottom = theme.icons .. "/panel/layouts/tilebottom.png"
theme.layout_tiletop    = theme.icons .. "/panel/layouts/tiletop.png"

-- | Language | -- 
theme.english = theme.icons .. "/english.png"
theme.russian = theme.icons .. "/russian.png"


-- | Taglist | --

theme.taglist_bg_empty    = "#d6d6d6"--"png:" .. theme.icons .. "/panel/taglist/empty.png"
theme.taglist_bg_occupied = "#d6d6d6"--"png:" .. theme.icons .. "/panel/taglist/occupied.png"
theme.taglist_bg_urgent   = "#d6d6d6"--"png:" .. theme.icons .. "/panel/taglist/urgent.png"
theme.taglist_bg_focus    = "#A4A4A4"--"png:" .. theme.icons .. "/panel/taglist/focus.png"
theme.taglist_font        = "Ohsnap 11"

-- | Tasklist | --

theme.tasklist_font                 = "Ohsnap 8"
theme.tasklist_disable_icon         = true
theme.tasklist_bg_normal            = "png:" .. theme.icons .. "panel/tasklist/normal.png"
theme.tasklist_bg_focus             = "png:" .. theme.icons .. "panel/tasklist/focus.png"
theme.tasklist_bg_urgent            = "png:" .. theme.icons .. "panel/tasklist/urgent.png"
theme.tasklist_fg_focus             = "#A4A4A4"
theme.tasklist_fg_urgent            = "#505050"
theme.tasklist_fg_normal            = "#5a5a5a"
theme.tasklist_floating             = ""
theme.tasklist_sticky               = ""
theme.tasklist_ontop                = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- | Widget | --

theme.widget_display   = theme.icons .. "/panel/widgets/display/widget_display.png"
theme.widget_display_r = theme.icons .. "/panel/widgets/display/widget_display_r.png"
theme.widget_display_c = theme.icons .. "/panel/widgets/display/widget_display_c.png"
theme.widget_display_l = theme.icons .. "/panel/widgets/display/widget_display_l.png"

-- | MPD | --

theme.mpd_prev  = theme.icons .. "/panel/widgets/mpd/mpd_prev.png"
theme.mpd_nex   = theme.icons .. "/panel/widgets/mpd/mpd_next.png"
theme.mpd_stop  = theme.icons .. "/panel/widgets/mpd/mpd_stop.png"
theme.mpd_pause = theme.icons .. "/panel/widgets/mpd/mpd_pause.png"
theme.mpd_play  = theme.icons .. "/panel/widgets/mpd/mpd_play.png"
theme.mpd_sepr  = theme.icons .. "/panel/widgets/mpd/mpd_sepr.png"
theme.mpd_sepl  = theme.icons .. "/panel/widgets/mpd/mpd_sepl.png"

-- | Separators | --

theme.spr    = theme.icons .. "/panel/separators/spr.png"
theme.sprtr  = theme.icons .. "/panel/separators/sprtr.png"
theme.spr4px = theme.icons .. "/panel/separators/spr4px.png"
theme.spr5px = theme.icons .. "/panel/separators/spr5px.png"

-- | Clock / Calendar | --

theme.widget_clock = theme.icons .. "/panel/widgets/widget_clock.png"
theme.widget_cal   = theme.icons .. "/panel/widgets/widget_cal.png"

-- | CPU / TMP | --

theme.widget_cpu    = theme.icons .. "/panel/widgets/widget_cpu.png"
-- theme.widget_tmp = theme.icons .. "/panel/widgets/widget_tmp.png"

-- | MEM | --

theme.widget_mem = theme.icons .. "/panel/widgets/widget_mem.png"

-- | FS | --

theme.widget_fs     = theme.icons .. "/panel/widgets/widget_fs.png"
theme.widget_fs_hdd = theme.icons .. "/panel/widgets/widget_fs_hdd.png"

-- | Mail | --

theme.widget_mail = theme.icons .. "/panel/widgets/widget_mail.png"

-- | Volume | --

--theme.widget_volume = theme.icons .. "/panel/widgets/widget_volume.png"

-- | NET | --

theme.widget_netdl = theme.icons .. "/panel/widgets/widget_netdl.png"
theme.widget_netul = theme.icons .. "/panel/widgets/widget_netul.png"

-- | Misc | --

theme.menu_submenu_icon = theme.icons .. "submenu.png"

return theme

