local awful     = require("awful")

local helpers = {}

helpers.ICON_DIR      = awful.util.getdir("config").."/modules/simple/icons/"

function helpers.is_dpms_enabled()
    local f = io.popen("xset q | grep Enabled")
    return f:read() or false
end

return helpers
