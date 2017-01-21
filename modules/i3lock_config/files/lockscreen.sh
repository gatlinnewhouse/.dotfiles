#!/bin/bash
convert ~/Pictures/lockscreenbkg.png -scale 25% -scale 400% -fill black -colorize 75% /tmp/screen.png
convert /tmp/screen.png ~/Pictures/lockimage.png -gravity center -composite -matte /tmp/screen.png
i3lock -u -i /tmp/screen.png
rm /tmp/screen.png
