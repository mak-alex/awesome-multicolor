require'core/widgets/generateMenu'
-- {{{ Themes manager

function getUsedThemeName()
  local cfg_path = _Awesome.config --awful.util.getdir("config")
  local cmd = "ls -1 " .. cfg_path .. "/themes/"
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

--themename = getUsedThemeName()
--_Awesome.themename = themename

require'core.widgets.generateMenu'
--if themename == nil or themename == ''
--then
--  themename = _Awesome.themename or 'solarized-dark'
--  theme_load(themename)
--end
_Awesome.beautiful.init(_Awesome.path.themes .. _Awesome.themename .. "/theme.lua")
_Awesome.awful.util.spawn("xrdb -load " .. _Awesome.path.themes .. _Awesome.themename .. '/Xdefaults')
-- }}}
