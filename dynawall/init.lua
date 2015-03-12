local dyna={}
function dyna.wall(state, dirname)
	local dynamic_wallpaper = state
	local dynamic_wallpaper_dir = dirname

	if dynamic_wallpaper then
		x = 0
		mytimer = timer { timeout = x }
		mytimer:connect_signal("timeout", function()
			local command_for_select = 'find '.. dynamic_wallpaper_dir ..' -type f -name "*.jpg" -o -name "*.png" | shuf -n 1'
			local f = assert(io.popen(command_for_select, 'r'))
		  local filename = assert(f:read('*a'))
		  f:close()
			filename = string.gsub(filename, '[\n\r]+', '')
			for s = 1,screen.count() do
	  		gears.wallpaper.maximized(filename, s, true)
			end
	  	-- stop the timer (we don't need multiple instances running at the same time)
		  mytimer:stop()
	  	-- define the interval in which the next wallpaper change should occur in seconds
		  -- (in this case anytime between 40 and 80 minutes)
	  	x = math.random( 2400, 4800)
		  --restart the timer
	  	mytimer.timeout = x
		  mytimer:start()
		end)
		-- initial start when rc.lua is first run
		mytimer:start()
	end
end
return dyna