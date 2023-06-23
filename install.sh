#!/bin/bash
xdotool=$(which xdotool)
if [ -z ${xdotool} ]; then
  echo "xdotool not found. Please install it and try again."
  exit 1
fi
COMPOSE_FILE='/usr/share/X11/locale/en_US.UTF-8/Compose'
#GTK2_FILE='/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules.cache'
GTK3_FILE='/usr/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules.cache'
ENV_FILE='/etc/environment'
sudo cp ${COMPOSE_FILE} ${COMPOSE_FILE}.bak
#sudo cp ${GTK2_FILE} ${GTK2_FILE}.bak
sudo cp ${GTK3_FILE} ${GTK3_FILE}.bak
sudo sed --in-place -e 's/ć/ç/g' ${COMPOSE_FILE}
sudo sed --in-place -e 's/Ć/Ç/g' ${COMPOSE_FILE}
GTK_FILE_SEARCH_FOR='^"cedilla".*:en'
GTK_FILE_SED_EXP='s/^\(\"cedilla\".*:wa\)/\1:en/g'
#grep -q ${GTK_FILE_SEARCH_FOR} ${GTK2_FILE}
#[ $? -eq 1 ] && sudo sed --in-place -e ${GTK_FILE_SED_EXP} ${GTK2_FILE}
grep -q ${GTK_FILE_SEARCH_FOR} ${GTK3_FILE}
[ $? -eq 1 ] && sudo sed --in-place -e ${GTK_FILE_SED_EXP} ${GTK3_FILE}
ENV_FILE_GTK_LINE='GTK_IM_MODULE=cedilla'
ENV_FILE_QT_LINE='QT_IM_MODULE=cedilla'
grep -q ${ENV_FILE_GTK_LINE} ${ENV_FILE}
[ $? -eq 1 ] && echo ${ENV_FILE_GTK_LINE} | sudo tee -a ${ENV_FILE} > /dev/null
grep -q ${ENV_FILE_QT_LINE} ${ENV_FILE}
[ $? -eq 1 ] && echo ${ENV_FILE_QT_LINE} | sudo tee -a ${ENV_FILE} > /dev/null
setxkbmap -layout us -variant altgr-intl -option "compose:ralt" -option "nbsp:level3" -option "lv3:ralt_switch"
xmodmap -e "keycode 42 = h H h H NoSymbol NoSymbol U203A U2039"
xmodmap -e "keycode 52 = g G g G NoSymbol NoSymbol masculine ordfeminine"
echo "Please log out then log in."
