
mkdir -p ~/.local/share/kservices5/
mkdir -p ~/.local/share/dbus-1/services/

npm install
rsync -a --exclude="assets" --exclude=".*" . $HOME/.local/share/kservices5/kolors
sed "s|%{DIR}|${HOME}/.local/share/kservices5/kolors|" "com.github.belka-kolors.service" > $HOME/.local/share/dbus-1/services/com.github.belka-kolors.service

kquitapp5 krunner 2> /dev/null
npm start --prefix "/home/belka/.local/share/kservices5/kolors" &> /dev/null &

disown
exit 0