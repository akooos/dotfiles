#!/bin/bash

compton --config $HOME/.config/compton/compton.conf
xset b off
xset dpms 600
xsetroot -solid '#000000'

mons=$(xrandr --listmonitors | grep -c "VGA")

if [[ $mons != 0 ]]; then
   echo 'Setting X layout!'
   sh ~/.screenlayout/iroasztalom.sh
fi

#hsetroot -solid "#000000"
for item in "$HOME/bin/wallpaper_change.sh"\
    'numlockx'\
    'nm-applet' \
    'xscreensaver -nosplash'\
    'pasystray'\
    'blueman-applet'\
    'dropbox'\
    'thunderbird'\
    'skype'\
    'hp-systray'\
    '/opt/grive-tools/grive-indicator';\
    do
        cmd="$item &>/dev/null & disown";
        eval $cmd;
    done
