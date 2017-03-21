#!/bin/bash

function install_qt {
  desktop_file="[Desktop Entry]
Type=Application
Exec=/var/tmp/Qt/Tools/QtCreator/bin/qtcreator
Name=Qt Creator (Community)
GenericName=The IDE of choice for Qt development.
Icon=QtProject-qtcreator
Terminal=false
Categories=Development;IDE;Qt;
MimeType=text/x-c++src;text/x-c++hdr;text/x-xsrc;application/x-designer;application/vnd.qt.qmakeprofile;application/vnd.qt.xml.resource;text/x-qml;text/x-qt.qml;text/x-qt.qbs"
  if [ -f /var/tmp/Qt/MaintenanceTool ]; then
    echo "$desktop_file" > "$HOME/Bureau/qtcreator.desktop"
    chmod u+x "$HOME/Bureau/qtcreator.desktop"
  else
    if zenity --question --title="Qt 5.8.0" --text="Voulez vous installer la dernière version de Qt ?"; then
      curl -sL -o /tmp/qt-installer.run "http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run"
      chmod u+x /tmp/qt-installer.run
      /tmp/qt-installer TargetDir=/var/tmp/Qt
      echo "$desktop_file" > "$HOME/Bureau/qtcreator.desktop"
      chmod u+x "$HOME/Bureau/qtcreator.desktop"
    fi
  fi
}

function wallpaper_ilovebash {
  curl -so "$HOME/.cache/the_dark_side/i-love-bash.zip" http://www.tux-planet.fr/public/images/wallpapers/linux/shell/i-love-bash.zip
  unzip -o "$HOME/.cache/the_dark_side/i-love-bash.zip" -d "$HOME/.cache/the_dark_side/"
  rm "$HOME/.cache/the_dark_side/i-love-bash.zip"
  xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -t string -s "$HOME/.cache/the_dark_side/i-love-bash/ILoveBash_1920x1200.png"
}

function install_cursor_batman {
  curl -so "$HOME/.cache/the_dark_side/cursor_batman.tar.bz2" "http://orig10.deviantart.net/0fdb/f/2012/200/c/8/batman_the_dark_knight_rises_by_grynays-d57sdfx.tar.bz2"
  tar xf "$HOME/.cache/the_dark_side/cursor_batman.tar.bz2" -C "$HOME/.icons/"
  xfconf-query -n -c xsettings -p /Gtk/CursorThemeName -t string -s BatmanTheDarkKnightRises
}

function add_english_things {
  DESKTOP="$(xdg-user-dir DESKTOP)"
  echo "[Desktop Entry]
Encoding=UTF-8
Name=Anglais Discord
Type=Link
URL=https://discord.gg/dvbhh6w
Icon=hipchat" > "$DESKTOP/an_discord.desktop"
  git clone git@github.com:L0L022/projet7.git "$HOME/Bureau/projet7"
}

function copy_ssh {
  #ssh-keyscan github.com >> ~/.ssh/known_hosts
  mkdir ~/.ssh
  cp ~/net-home/ssh/* ~/.ssh/
  chmod 400 ~/.ssh/id_rsa*
}

function install_atom_theme {
  apm install "$1" "$2"
  sed -i -e "s/northem-dark-atom-ui/$1/g" -e "s/atom-monokai/$2/g" "$HOME/.atom/config.cson"
}

#alex
if echo "$USER" | grep -q "d16007062"; then
  rm /home/d16007062/Bureau/{chromium,blender,web-spotify}.desktop
  xfdesktop --arrange
  xdg-mime default firefox-esr.desktop text/html
  cp -f "$HOME/.local/share/applications/mimeapps.list" "$HOME/.config/"
  git config --global user.name "bohrin"
  git config --global user.email "alex.dejaegher@gmail.com"
  git config --global push.default simple
  copy_ssh
  git clone git@github.com:L0L022/projet_bash.git "$HOME/Bureau/projet_bash"
  install_atom_theme seti-ui seti-syntax
  #install_cursor_batman
  add_english_things
fi

#loic e
if echo "$USER" | grep -q "e16006130"; then
  bash "$HOME/net-home/start_git.bash"
  copy_ssh
  git clone git@github.com:L0L022/sem1_iut.git "$HOME/Bureau/sem1_iut"
  git clone git@github.com:L0L022/sem2_iut.git "$HOME/Bureau/sem2_iut"
  git clone git@github.com:L0L022/projet_bash.git "$HOME/Bureau/projet_bash"
  add_english_things
  install_qt
fi

#hugo
if echo "$USER" | grep -q "d16002496"; then
  xfconf-query -n -c xfce4-panel -p /panels/panel-1/nrows -t int -s 1
  xfconf-query -n -c xfce4-panel -p /plugins/plugin-4/rows -t int -s 1
  xfconf-query -n -c xsettings -p /Net/ThemeName -t string -s Adwaita
  xfconf-query -n -c xsettings -p /Net/IconThemeName -t string -s Moka
  xfconf-query -n -c xfwm4 -p /general/theme -t string -s Arc
  install_atom_theme atom-material-ui atom-material-syntax-light
  add_english_things
fi

#leo
if echo "$USER" | grep -q "s16001821"; then
  xfconf-query -n -c xfwm4 -p /general/workspace_count -t int -s 4
  git clone https://github.com/LinkIsACake/IUT.git "$HOME/Bureau/IUT"
fi

#loic l
if echo "$USER" | grep -q "l16002580"; then
  add_english_things
fi

#martin
if echo "$USER" | grep -q "a16000520"; then
  add_english_things
fi

#laurent
if echo "$USER" | grep -q "d16013526"; then
  add_english_things
fi

#killian
if echo "$USER" | grep -q "w16003485"; then
  add_english_things
fi
