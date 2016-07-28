userConfig={
  browser = {
    command = "xdg-open",
    hotkey = 'w', -- win + shift + w
  },
  email = {
    --command = 'urxvt -name mutt -e mutt',
    command = 'xdg-open https://mail.yandex.kz/',
    hotkey = 'm', -- win + shift + m
  },
  terminal = {
    command = "urxvt -geometry 110x40",
    hotkey = 'Return', -- Win + Return
  },
  graphic = {
    --command = 'gimp',
    command = 'xdg-open https://befunky.com/create/',
    hotkey = ''
  },
  editor = {
    command = 'emacs',
    hotkey = 'e'
  },
  editor_cmd = {
    command = "urxvt -e vim",
    hotkey = '',
  },
  filemanager = {
    --command = 'spacefm'
    command = "urxvt -name ranger -e ranger",
    hotkey = 'f' -- win + shift + f
  },
  imclient = {
    --command = 'urxvt -name mcabber -e mcabber',
    command = 'xdg-open https://plus.im',
    hotkey = 'i' -- win + shift + i
  },
  -- Other settings,
  dynamic_tagging = true,
  modkey = "Mod4",
  altkey = "Mod1",
  theme = 'pro-dark',
  lockscreen = 'xlock -mode ant3d',
}
