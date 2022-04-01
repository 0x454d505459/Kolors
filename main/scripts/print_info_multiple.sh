#!/bin/sh
output="$(pastel $1 | pastel format $2 2>&1)" || output="$(pastel $1)"
echo "$output"
