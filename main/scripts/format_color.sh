color=$(echo "$1" | pastel format hex 2>&1)
if [ $? -eq 0 ]; then
printf "$color"
else
exit 1
fi