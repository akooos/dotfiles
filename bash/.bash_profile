#
# ~/.bash_profile
#

#because of ntp service
export TZ='Europe/Budapest';

if [[ "$XDG_CURRENT_DESKTOP" == "i3" ]]; then
    echo "Setting envs!"
    # QT:
    # Show icons and basicly qt application properly
    export QT_QPA_PLATFORMTHEME="qt5ct"
    # Disable Qt accessibility features
    export QT_ACCESSIBILITY=0;
    #GTK2
    export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
    export $(dbus-launch);
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
