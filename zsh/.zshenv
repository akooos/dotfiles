
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ $XDG_CURRENT_DESKTOP == "i3" || $XDG_CURRENT_DESKTOP == "sway" ]]; then
    export QT_ACCESSIBILITY=0
    export QT_QPA_PLATFORMTHEME="qt5ct";
fi
