#!/bin/sh
while IFS= read -r color && [ "$color" ]; do
echo "$color"
done <<< $(echo "$(echo "$1" | pastel format hex)"
echo "$(echo "$1" | pastel format hsl)"
echo "$(echo "$1" | pastel format lch)"
echo "$(echo "$1" | pastel format rgb)"
echo "$(echo "$1" | pastel format name)")