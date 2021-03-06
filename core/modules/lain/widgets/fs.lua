local helpers      = require("core.modules.lain.helpers")

local beautiful    = require("beautiful")
local wibox        = require("wibox")
local naughty      = require("naughty")

local io           = { popen  = io.popen }
local pairs        = pairs
local string       = { match  = string.match,
                       format = string.format }
local tonumber     = tonumber

local setmetatable = setmetatable

-- File system disk space usage
-- lain.widgets.fs
local fs = {}

local notification  = nil
fs_notification_preset = { fg = beautiful.fg_normal }

function fs:hide()
    if notification ~= nil then
        _Awesome.naughty.destroy(notification)
        notification = nil
    end
end

function fs:show(t_out)
    fs:hide()

    local f = io.popen(helpers.scripts_dir .. "dfs")
    ws = f:read("*a"):gsub("\n*$", "")
    f:close()

    notification = _Awesome.naughty.notify({
        preset = fs_notification_preset,
        text = ws,
        timeout = t_out,
        border_width = 3,
        border_color = "#7788af"
    })
end

-- Unit definitions
local unit = { ["mb"] = 1024, ["gb"] = 1024^2 }

local function worker(args)
    local args      = args or {}
    local timeout   = args.timeout or 600
    local partition = args.partition or "/"
    local settings  = args.settings or function() end

    fs.widget = wibox.widget.textbox('')

    helpers.set_map("fs", false)

    function update()
        fs_info = {}
        fs_now  = {}
        local f = io.popen("LC_ALL=C df -kP " .. partition)

        for line in f:lines() do -- Match: (size) (used)(avail)(use%) (mount)
            local s     = string.match(line, "^.-[%s]([%d]+)")
            local u,a,p = string.match(line, "([%d]+)[%D]+([%d]+)[%D]+([%d]+)%%")
            local m     = string.match(line, "%%[%s]([%p%w]+)")

            if u and m then -- Handle 1st line and broken regexp
                fs_info[m .. " size_mb"]  = string.format("%.1f", tonumber(s) / unit["mb"])
                fs_info[m .. " size_gb"]  = string.format("%.1f", tonumber(s) / unit["gb"])
                fs_info[m .. " used_p"]   = tonumber(p)
                fs_info[m .. " avail_p"]  = 100 - tonumber(p)
            end
        end

        f:close()

        fs_now.used      = tonumber(fs_info[partition .. " used_p"])  or 0
        fs_now.available = tonumber(fs_info[partition .. " avail_p"]) or 0
        fs_now.size_mb   = tonumber(fs_info[partition .. " size_mb"]) or 0
        fs_now.size_gb   = tonumber(fs_info[partition .. " size_gb"]) or 0

        widget = fs.widget
        settings()

        if fs_now.used >= 99 and not helpers.get_map("fs")
        then
            _Awesome.naughty.notify({
                title = "warning",
                text = partition .. " ran out!\nmake some room",
                timeout = 8,
                fg = "#000000",
                bg = "#FFFFFF",
                border_width = 3,
                border_color = "#7788af"
            })
            helpers.set_map("fs", true)
        else
            helpers.set_map("fs", false)
        end
    end

    helpers.newtimer(partition, timeout, update)

    widget:connect_signal('mouse::enter', function () fs:show(0) end)
    widget:connect_signal('mouse::leave', function () fs:hide() end)

    return setmetatable(fs, { __index = fs.widget })
end

return setmetatable(fs, { __call = function(_, ...) return worker(...) end })
