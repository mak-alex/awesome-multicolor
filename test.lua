
-- List your theme files and feed the menu table
   local cmd = "ls -1 ~/.config/awesome/themes/usedTheme/"

   local f = io.popen(cmd)

   for l in f:lines() do
	   print(l)
   end
   f:close()
