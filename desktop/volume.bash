#!/bin/bash

if amixer | grep 'Playback' | grep -q '\[off\]'; then
  zenity --warning --height=0 --icon-name="notification-audio-volume-muted" --title="Son coupé" --text="Le son est actuellement coupé.\nPour le remettre appuyez sur la touche <b>m</b>.\n(dans l’interface qui s’ouvrira à la fermeture de ce message)"
fi
xfce4-terminal -T Volume -I multimedia-volume-control --hide-menubar -e /usr/bin/alsamixer
