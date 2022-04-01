#!/bin/sh
color=$(echo "$1" | pastel format $2 2>&1)
if [ $? -eq 0 ]; then
printf "$color"
else
exit 1
fi