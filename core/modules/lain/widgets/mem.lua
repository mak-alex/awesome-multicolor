local newtimer        = require("core.modules.lain.helpers").newtimer
regologo              = _Awesome.wibox.widget.textbox()
local wibox           = require("wibox")

local io              = { lines  = io.lines }
local math            = { floor  = math.floor }
local string          = { format = string.format,
                          gmatch = string.gmatch,
                          len    = string.len }

local setmetatable    = setmetatable
regologo:set_markup( '<span color="#e54c62">M.A.K.</span> ')
-- Memory usage (ignoring caches)
-- lain.widgets.mem
local mem = {}
local notification  = nil
mem_notification_preset = { fg = _Awesome.beautiful.fg_normal }

function mem:hide()
    if notification ~= nil then
        _Awesome.naughty.destroy(notification)
        notification = nil
    end
end

function mem:show(t_out)
    mem:hide()
    ws = [[
  <span font="" color='#87af5f'>_NAME CONFIG</span>    <span font="" color='#e33a6e'>"FH-MultiColor"</span>
  <span font="" color='#87af5f'>_VERSION</span>        <span font="" color='#e33a6e'>'MULTICOLOR v0.1.0-rc1'</span>
  <span font="" color='#87af5f'>_URL</span>            <span font="" color='#e33a6e'>'https://bitbucket.org/enlab/multicolor'</span>
  <span font="" color='#87af5f'>_MAIL</span>           <span font="" color='#e33a6e'>'flashhacker1988@gmail.com'</span>
    ]]

    notification = _Awesome.naughty.notify({
        preset = mem_notification_preset,
        text = ws,
        timeout = t_out,
        border_width = 3,
        border_color = "#7788af"
    })
end

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 3
    local settings = args.settings or function() end

    mem.widget = wibox.widget.textbox('')

    function update()
        mem_now = {}
        for line in io.lines("/proc/meminfo")
        do
            for k, v in string.gmatch(line, "([%a]+):[%s]+([%d]+).+")
            do
                if     k == "MemTotal"  then mem_now.total = math.floor(v / 1024)
                elseif k == "MemFree"   then mem_now.free  = math.floor(v / 1024)
                elseif k == "Buffers"   then mem_now.buf   = math.floor(v / 1024)
                elseif k == "Cached"    then mem_now.cache = math.floor(v / 1024)
                elseif k == "SwapTotal" then mem_now.swap  = math.floor(v / 1024)
                elseif k == "SwapFree"  then mem_now.swapf = math.floor(v / 1024)
                end
            end
        end

        mem_now.used = mem_now.total - (mem_now.free + mem_now.buf + mem_now.cache)
        mem_now.swapused = mem_now.swap - mem_now.swapf

        widget = mem.widget
        settings()
    end

    newtimer("mem", timeout, update)

    widget:connect_signal('mouse::enter', function () mem:show(0) end)
    widget:connect_signal('mouse::leave', function () mem:hide() end)

    return mem.widget
end

return setmetatable(mem, { __call = function(_, ...) return worker(...) end })
