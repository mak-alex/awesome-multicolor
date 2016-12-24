# Configuration multicolor for AwesomeWM

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

### Installation

**MultiColor** requires [AwesomeWM](https://awesomewm.org/) v3.5+ to run.
Download and extract the [latest pre-built release](https://bitbucket.org/enlab/multicolor/get/master.tar.gz) or clone repository:
```sh
$ git clone --depth=1 https://bitbucket.org/enlab/multicolor ~/.config/awesome
```
Install the dependencies:

```sh
$ # if you are using distro based Gentoo
$ sudo emerge -qavt dev-lua/luafilesystem 
$ sudo emerge -qavt x11-plugins/vicious
$ sudo emerge -qavt media-sound/mpd
$ # if you are using distro based Debian
$ sudo apt install lua-filesystem
$ sudo apt install awesome-extra # vicious
$ sudo apt install mpd
```

### Plugins

MultiColor is currently extended with the following plugins

* MPD
* DynamicTags
* DynamicMenu
* Manager themes

### Development

Want to contribute? Great!

All sources are located in the directory ~/.config/awesome:

rc.lua  - contains the base class for the formation of the desktop settings

Good luck!

### Todos
* To make the configuration in json and SQLite to dynamically work with desktop settings


License
----

MIT


**Free Software, Hell Yeah!**
