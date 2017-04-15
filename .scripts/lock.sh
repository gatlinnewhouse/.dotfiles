#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 25% -scale 400% -fill black -colorize 75% /tmp/screen.png
convert /tmp/screen.png /home/delueze/.dotfiles/scripts/ -gravity center -composite -matte /tmp/screen.png
i3lock -u -i /tmp/screen.png
rm /tmp/screen.png
