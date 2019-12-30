#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

env GDK_DPI_SCALE=0.5 GDK_SCALE=2

# source files

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Set DPI and scale
xrandr --dpi 157 --output eDP-1 --scale 2x2

# Restore ALSA settings
restore_alsa() {
 while [ -z "$(pidof pulseaudio)" ]; do
  sleep 0.5
 done
 alsactl -f /var/lib/alsa/asound.state restore 
}
restore_alsa &

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

urxvtc "$@"
if [ $? -eq 2 ]; then
  urxvtd -q -o -f
  urxvtc "$@"
fi

# start pulseeffects
#bash $HOME/.bin/pulseeffects-xvfb start &

unset GIT_ASKPASS
unset SSH_ASKPASS

# Load i3
i3
