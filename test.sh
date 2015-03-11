#!/bin/sh
##
## test.sh
##
## Author(s):
##  - Mikhailenko Alexandr Konstantinovich (a.k.a) Alex M.A.K
##  - <flashhacker1988@gmail.com>
##
## Copyright (C) 2015 Alex M.A.K
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
##
clear
# If example.rc.lua is missing, make a default one.
rc_lua=$PWD/rc.lua
test -f $rc_lua || /bin/cp /etc/xdg/awesome/rc.lua $rc_lua

# Just in case we're not running from /usr/bin
awesome=`which awesome`
xephyr=`which Xephyr`
pidof=`which pidof`

test -x $awesome || { echo "Awesome executable not found. Please install Awesome"; exit 1; }
test -x $xephyr || { echo "Xephyr executable not found. Please install Xephyr"; exit 1; }

function usage() {
cat <<USAGE
test.sh start|stop|restart|run

  start    Start nested Awesome in Xephyr
  stop     Stop Xephyr
  restart  Reload nested Awesome configuration
  run      Run command in nested Awesome

USAGE
exit 0
}

# WARNING: the following two functions expect that you only run one instance
# of Xephyr and the last launched Awesome runs in it

function awesome_pid() {
  $pidof awesome | cut -d\  -f1
}

function xephyr_pid() {
  $pidof Xephyr | cut -d\  -f1
}

[ $# -lt 1 ] && usage


case "$1" in
  start)
    $xephyr -ac -br -noreset -screen 800x600 :1 &
    sleep 1
    DISPLAY=:1.0 $awesome -c $rc_lua &
    sleep 1
    echo "Awesome ready for tests. PID is $(awesome_pid)"
    ;;
  stop)
    echo -n "Stopping Nested Awesome... "
    if [ -z $(xephyr_pid) ]; then
      echo "Not running: not stopped :)"
      exit 0
    else
      kill $(xephyr_pid)
      echo "Done."
    fi
    ;;
  restart)
    echo -n "Restarting Awesome... "
    kill -s SIGHUP $(awesome_pid)
    ;;
  run)
    shift
    DISPLAY=:1.0 "$@" &
    ;;
  *)
    usage
    ;;
esac