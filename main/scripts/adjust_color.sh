#!/bin/sh
color="$1"
shift
new_color=$(echo "$color" | pastel $*  2>&1 )
if [ $? -eq 0 ]; then 
printf "$(echo "$new_color" | pastel format hex)"
else 
printf "$color"
fi