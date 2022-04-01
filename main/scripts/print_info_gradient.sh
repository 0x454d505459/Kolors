#!/bin/sh
output="$(pastel "$1" "$2" "$3" | pastel format $4 2>&1)" || output="$(pastel $1 $2 $3)"
echo "$output"