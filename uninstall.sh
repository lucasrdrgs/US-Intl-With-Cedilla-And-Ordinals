#!/bin/bash
COMPOSE_FILE='/usr/share/X11/locale/en_US.UTF-8/Compose'
#GTK2_FILE='/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules.cache'
GTK3_FILE='/usr/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules.cache'
ENV_FILE='/etc/environment'
if [ -f ${COMPOSE_FILE}.bak ]; then
  sudo cp ${COMPOSE_FILE}.bak ${COMPOSE_FILE}
fi
#if [ -f ${GTK2_FILE}.bak ]; then
#  sudo cp ${GTK2_FILE}.bak ${GTK2_FILE}
#fi
if [ -f ${GTK3_FILE}.bak ]; then
  sudo cp ${GTK3_FILE}.bak ${GTK3_FILE}
fi
setxkbmap -layout us -variant altgr-intl -option "compose:ralt" -option "nbsp:level3" -option "lv3:ralt_switch"
xmodmap -e "keycode 42 = h H h H"
xmodmap -e "keycode 52 = g G g G"

