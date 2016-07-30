require'widgets/generateMenu'
-- {{{ Themes manager
function getUsedThemeName()
  local cfg_path = awful.util.getdir("config")
  local cmd = "ls -1 " .. cfg_path .. "/themes/.usedTheme/"
  local f = io.popen(cmd)
  local usedThemeName
  for theme in f:lines()
  do
    if theme ~= nil and theme ~= ''
    then
      return theme
    end
    return false
  end
  f:close()
end

themename = getUsedThemeName()

local generateMenu = require("widgets.generateMenu")
if themename == nil and themename == ''
then
  theme_load(userConfig.theme)
end
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/.usedTheme/"..themename.."/theme.lua")
-- }}}
