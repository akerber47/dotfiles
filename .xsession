#!/bin/sh
#
# ~/.xsession
#
# This file is your X (graphical) session. The display manager (gdm) runs the
# system-wide Xsession script which, in turn, runs this one.
#
# When this script terminates, your graphical session ends and the display
# manager restarts for the next user.
#
# The shell treats lines beginning with # as comments.
#
# EDIT THIS FILE to customize which programs get run on startup.
#
# EXAMPLES are available in /usr/local/doc/startups.
#

#
# Apply user settings for X.
#
# Your X resources are defined in ~/.Xdefaults.
#

xrdb -I$HOME -load $HOME/.Xdefaults

#
# Set your background color. Edit and uncomment one of the 'wmsetbg' lines to 
# display a background image.
#

xsetroot -solid $ROOTBG &
# wmsetbg --center $HOME/my_picture &         # scaled at 100%, centered
# wmsetbg --scale $HOME/my_picture &          # scaled up to fill the screen
# wmsetbg --tile $HOME/my_picture &           # tiled to fill the screen

# Launch some terminals.
# xterm -geometry 80x15+5-5 -C -name "`uname -n` console" &
# xterm -geometry 80x30+5+360 & (OH, COME ON!)

# Launch the programs in .config/autostart.
# zwgc is the 'zephyr windowgram client'. See zwgc(1) and zwrite(1) for more
# information.

for x in ~/.config/autostart/*
do
  exec=`grep "Exec" $x | cut -d= -f2-`
  eval $exec &
done

# If you want to run additional programs on startup, specify them here.
# ...
setxkbmap dvorak
xmodmap .Xmodmap
zwgc
xterm &
redshift-gtk -l 37.8717:-122.2728 &
#workrave &

# Force typing breaks
xwrits typetime=5 breaktime=:30 title=Micro canceltime=5 after=2 maxhands=20 +multiply &
xwrits typetime=55 breaktime=5 title=Macro canceltime=5 after=2 maxhands=20 +multiply &

# To configure workrave, look in ~/.gconf/apps/workrave/
#
# And we're done. Sit here and keep the session running until we quit.
#
#exec xfce
xmonad
# twm

#
# Your X session ends and the display manager restarts.
#
