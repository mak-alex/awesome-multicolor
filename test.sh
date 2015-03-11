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

Xephyr -ac -br -noreset -screen 640x480 :1 &
sleep 1 && DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua > ~/.xephyr_awesome.log
if [ $? == 1 ]; then
  echo 'error start DISPLAY=:1.0' >> ~/.test_awesome.log
fi1