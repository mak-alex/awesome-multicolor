##Multicolor Configuration for the awesome window manager (3.5)
* If you're disappointed by fonts, check your `~/.fonts.conf`. 
* It is presumed that you configure your autostart in `~/.xinitrc`.
* Help with hotkeys <F1>

##What do we have?
* Dynamic tags
* Terms tags for dynamic tags
* The drop-down terminal
* Running the backup configuration
* Widgets
* Generated applications menu
* Dynamic desktop background
* And many other amenities ...
 
##Capabilities
* Themes
* Dynamic wallpaper
* Test script for hacking
* Dynamic desktop tagging (via tyrannical)
* ALSA control (by Rman)
* Freedesktop menu
* Multiple desktop support
* Beautiful notifications (via naughty)

##Dependencies
* beautiful
* vicious
* naughty
* tyrannical (optional)
* Dynamic generate menu (via Alex M.A.K)
* Dropdown terminal (via Alex M.A.K)

##HOTKEYS:
* (If you want to change old bindings, open please bindings.lua file and edit...):
* Operations with MPD servers:
	* mpc|ncmpc|pms next:     alt_shift_(arrow_right)
	* mpc|ncmpc|pms prev:     alt_shift_(arrow_left)
	* mpc|ncmpc|pms toggle:   alt_shift_(arrow_up)
	* mpc|ncmpc|pms stop:     alt_shift_(arrow_down)
* Operations with audio:
	* volume up:              alt_(arrow_up)
	* volume down:            alt_(arrow_down)
	* volume mute:            alt_m
	* volumn 100%:            alt_ctrl_m
* Dynamic tags:
	* delete_tag:             win_d
	* new tag:                win_n
	* new tag with focussed:  win_shift_n
	* move to new tag:        win_alt_n
	* rename tag to focussed: win_alt_r
	* rename tag:             win_shift_r
	* term in current  tag:   win_alt_enter
	* new tag with term:      win_ctrl_enter
	* fork tag:               win_ctrl_f
	* aero tag:               win_a
	* tag view prev:          win_(arrow_left)
	* tag view next:          win_(arrow_right)
	* tag history restore:    win_Escape
* Terminal:
	* new terminal:           win_enter
	* dropdown terminal:      win_z
* Window:
	* open window fullscreen: win_f
	* maximized hor and vert: win_m
	* kill window:            win_shift_c
	* floating window:        win_ctrl_space
	* move left:              win_h 
    * move right:             win_l
    * move up:                win_k 
    * move down:              win_j
* Panel:
	* hide panels:            win_b
* Menu:
	* open dynamic menu:      win_w
* Awesome:
	* restart wm:             win_ctrl_enter
	* quit wm:                win_shift_q