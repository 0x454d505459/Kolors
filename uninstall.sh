#!/bin/bash

[[ -d $HOME/.local/share/kservices5/kolors ]] && rm -r $HOME/.local/share/kservices5/kolors
[[ -f $HOME/.local/share/dbus-1/services/com.github.belka-kolors.service ]] && rm $HOME/.local/share/dbus-1/services/com.github.belka-kolors.service

kill $(ps aux | grep "node" | grep "kolors" | awk '{print $2}') 2>/dev/null
kquitapp5 krunner
