#!/bin/sh
mkdir -p /tmp/kolor/
COLORHEX=$(echo $1 | pastel format hex 2>/dev/null) 
[ $? -eq 1 ] && exit 1
BASEDIR="/tmp/kolor"
FILENAME="KOLOR_$COLORHEX.png"
THUMBDIR=$BASEDIR/$FILENAME

draw_color() {
convert -size 50x50 xc:transparent -stroke transparent -strokewidth 1 \
 -fill "$1" -draw "circle 25,25,25,5" "$2"
}

[[ ! -f $THUMBDIR ]] && draw_color "$COLORHEX" "$THUMBDIR" 
printf "$THUMBDIR"