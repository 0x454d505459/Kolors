npm install
cp plasma-runner-kolors.desktop ~/.local/share/kservices5/
kquitapp5 krunner 2> /dev/null; kstart5 --windowclass krunner krunner > /dev/null 2>&1 &
npm start