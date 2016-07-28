-- {{{ Autorun apps
local flags = {}
for k,v in pairs(require('modules.autorun.programms'))
do
  for i=1, #v
  do
    if not flags[v[i]]
    then
      run_once(tostring(v[i]))
    end
  end
end
-- }}}
