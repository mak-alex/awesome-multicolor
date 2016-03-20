## Представляю Вашему вниманию MultiColor v. 2.0 (awesome 3.5.x)
* Динамические теги
* Множество оформлений
* Динамическое меню
* Динамеческое суб-меню для конфигурации MultiColor
* Динамическое суб-меню для выбора темы без редактирования каких либо файлов
* Только необходимые виджеты
* Музыкальный модуль (awesomempd) с динамическим меню:
	* Модуль di.fm с динамическим меню выбора станции
	* Модуль 101.ru с динамическим меню выбора станции
	* Модуль Jamendo 
* Резервирование текущей рабочей конфигурации
* Восстановление из резервной конфигурации
* И многое другое...
* Динамический справочник

![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-185402_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164408_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164428_1920x1080_scrot.png)

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

![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164445_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164502_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-184859_1920x1080_scrot.png)

## Fix bug: при смене раскладки, не возможно по клику, переходить по вкладкам
* откройте файл /usr/share/X11/xkb/compat/basic
	* найдите и закомментируйте эти строк:
	    *  group 2 = AltGr; 
	    *  group 3 = AltGr; 
	    *  group 4 = AltGr; 

![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164516_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164532_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-185033_1920x1080_scrot.png)

## Зависимости:
* Awesome 3.5.x
* URxvt
* Cairo-Compmgr (не обязательный)
* Mpd+Ncmpcpp or Ncmcp or Mpc
* Unclutter (не обязательный)
* mcabber (не обязательный)
* Mutt (не обязательный)
* Ranger
* Xlock

## Основные хоткеи:
	* Awesome  
		* ^ + ⊞ + r  -  Перезагрузить Awesome
		* ⇧ + ⊞ + q  -  Выйти из Awesome
	* Дисплей  
		* ⊞ + Up  -  Прибавить яркость на 10%
		* ⊞ + Down  -  Понизить яркость на 10%
		* ^ + ⊞ + Up  -  Прибавить яркость на 100%
		* ^ + ⊞ + Down  -  Понизить яркость на 100%
	* Звук  
		*  alt + Up  -  Прибавить громкость на 1%
		* alt + Down  -  Понизить громкость на 1%
		* alt + F3  -  Почтовое приложение Mutt
		* alt + F4  -  IM Client Mcabber
		* alt + F5  -  FileManager Ranger
		* alt + m  -  Выключить звук
		* ^ + alt + m  -  Прибавить громкость на 100%
	* Калькуляторы  
		* ⊞ + F11  -  Простой калькулятор
	* Меню  
		* ⊞ + w  -  Генерируемое меню приложений
		* ⊞ + r  -  Строка запуска
		* alt + ⊞ + l  -  Выход, блокировка экрана и т.д.
	* Музыка  
		* ^ + alt + Up  -  Пориостановить проигрывание
		* ^ + alt + Down  -  Остановить проигрывание
		* ^ + alt + Left  -  Предыдущий трек
		* ^ + alt + Right  -  Следующий трек
	* Окна  
		* ⊞ + Tab  -  Переключение между окнами
		* alt + Tab  -  Переключение между окнами
		* alt + Tab  -  Переключение между окнами
	* Панель  
		* ⊞ + b  -  Скрыть панели
		* alt + c  -  Показать календарь
		* alt + h  -  Показать df -h
	* Поисковики  
		* alt + F12  -  Поиск в Google
	* Помощь  
		* ⊞ + F1  -  Справочнег
	* Теги  
		* ⊞ + Left  -  Перейти на тег слева
		* ⊞ + Right  -  Перейти на тег справа
		* ⊞ + Escape  -  Перейти на последний посещаемый тег
		* ⇧ + ⊞ + r  -  Переименовать тег
		* ⊞ + d  -  Удалить тег
		* ⊞ + n  -  Добавить тег
		* ⇧ + ⊞ + n  -  Добавить тег и перенести в него работающее приложение
		* alt + ⊞ + r  -  Переименовать тег именем открытого приложения
		* alt + ⊞ + Return  -  Открыть терминал в текущем теге
		* ^ + ⊞ + Return  -  Добавить тег и открыть на нем терминал
		* ^ + ⊞ + f  -  Форк тега
		* ⊞ + a  -  Аеро тег (объядинение двух тегов в одном)
	* Терминалы  
		* ⊞ + Return  -  Стандартный терминал
		* ⊞ + z  -  Простой выпадающий терминал
	* Фокус окон  
		* ⊞ + j  -  Фокус окна снизу
		* ⊞ + k  -  Фокус окна сверху
		* ⊞ + h  -  Фокус окна слева
		* ⊞ + l  -  Фокус окна справа
	* Скриншот
		* ⊞ + Сtrl + F12 - Сделать скриншот

![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164543_1920x1080_scrot.png)
![ScreenShot](https://bitbucket.org/enlab/multicolor/raw/master/screenshots/2016-03-18-164559_1920x1080_scrot.png)
