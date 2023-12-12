#!/bin/bash

check_deps() {
if ! [ -x "$(command -v convert)" ] || ! [ -x "$(command -v pastel)" ]; then
  kdialog --error "\nYou need pastel and imagemagick to use this runner."
  exit 1
fi
}

check_deps
mkdir -p $HOME/.local/share/kservices5/
mkdir -p $HOME/.local/share/dbus-1/services/

npm install > /dev/null 2>&1

rsync -a --exclude=".*" . $HOME/.local/share/kservices5/kolors
chmod +x $HOME/.local/share/kservices5/kolors/main/index.js
sed "s|%{DIR}|${HOME}/.local/share/kservices5/kolors/main/index.js|" "com.github.belka-kolors.service" > $HOME/.local/share/dbus-1/services/com.github.belka-kolors.service

kquitapp5 krunner 2> /dev/null

kill $(ps aux | grep "node" | grep "kolors" | awk '{print $2}') 2>/dev/null
$HOME/.local/share/kservices5/kolors/main/index.js & >/dev/null

disown
exit 0