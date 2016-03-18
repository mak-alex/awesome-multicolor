## Представляю Вашему вниманию MultiColor v. 2.0 (awesome 3.5.x)
* Скриншоты вы найдете в директории screenshots
* Вызов справки <Win>+<F1>

![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164408_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164428_1920x1080_scrot.png)

## Что под капотом?
* Динамические теги
* Множество оформлений
* Динамическое меню
* Динамеческое суб-меню для конфигурации MultiColor
* Динамическое суб-меню для выбора темы без редактирования каких либо файлов
* Только необходимые виджеты
* Музыкальный модуль (awesomempd) с динамическим меню и радио-списком (di.fm)
* Резервирование текущей рабочей конфигурации
* Восстановление из резервной конфигурации
* И многое другое...

![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164445_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164502_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-184859_1920x1080_scrot.png)

## Структура конфигурации MultiColor
* Директория awesome (multicolor) содержит:
    * config - содержит в основные конфигурационные файлы, такие как:
        * awesome.lua - основной файл со всей несущей конфигурации для awesome 3.5.x
        * .awesome.default.lua - резервная копия последней работающей конфигурации MultiColor
        * bindings.lua - файл с конфигурацией хоткеев как глобальных так и нет
        * tags.lua - файл с конфигурацией рабочего пространства и настройками динамических тегов
        * fallback_tags.lua - файл с конфигурацией рабочего пространства и отключенными динамическими тегами
    * modules - содержит сторонние и не только модули
    * widgets - содержит основные виджеты
    * themes - содержит основные темы (8 штук)
    * screenshots - без вариантов ;-)

## Fix bug: при смене раскладки, не возможно по клику, переходить по вкладкам
* откройте файл /usr/share/X11/xkb/compat/basic
	* найдите и закомментируйте эти строк:
	    *  group 2 = AltGr; 
	    *  group 3 = AltGr; 
	    *  group 4 = AltGr; 

![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164516_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164532_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-185033_1920x1080_scrot.png)

## Основные хоткеи:
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

![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164543_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164559_1920x1080_scrot.png)