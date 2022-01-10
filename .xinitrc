setxkbmap -model abnt -layout br -variant abnt2
xrdb -merge ~/.Xresources
feh --bg-max --randomize ~/.wallpaper/* &
slstatus &
exec dwm && dmenu
