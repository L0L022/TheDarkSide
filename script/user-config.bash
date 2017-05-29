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
      /tmp/qt-installer.run TargetDir=/var/tmp/Qt
      echo "$desktop_file" > "$HOME/Bureau/qtcreator.desktop"
      chmod u+x "$HOME/Bureau/qtcreator.desktop"
    else
      cp "/usr/share/applications/qtcreator.desktop" "$HOME/Bureau/qtcreator.desktop"
    fi
  fi
}

function install_boost {
  old="$PWD"
  cd /var/tmp/ || exit
  curl -sL -o boost.tar.bz2 "https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2"
  tar xf boost.tar.bz2
  cd boost_1_64_0 || exit
  ./bootstrap.sh
  ./b2 --with-test --with-signals
  cd "$old" || exit
  sed -i "s|^\"\*\":$|\"*\":\n  \"build-cmake\":\n    cmake_arguments: \" -DCMAKE_BUILD_TYPE=Debug -DBOOST_ROOT=/var/tmp/boost_1_64_0 -DBoost_NO_SYSTEM_PATHS=ON\"|g" "$HOME/.atom/config.cson"
}

function wallpaper_ilovebash {
  curl -so "$HOME/.cache/TheDarkSide/i-love-bash.zip" http://www.tux-planet.fr/public/images/wallpapers/linux/shell/i-love-bash.zip
  unzip -o "$HOME/.cache/TheDarkSide/i-love-bash.zip" -d "$HOME/.cache/TheDarkSide/"
  rm "$HOME/.cache/TheDarkSide/i-love-bash.zip"
  xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -t string -s "$HOME/.cache/TheDarkSide/i-love-bash/ILoveBash_1920x1200.png"
}

function install_cursor_batman {
  curl -so "$HOME/.cache/TheDarkSide/cursor_batman.tar.bz2" "http://orig10.deviantart.net/0fdb/f/2012/200/c/8/batman_the_dark_knight_rises_by_grynays-d57sdfx.tar.bz2"
  tar xf "$HOME/.cache/TheDarkSide/cursor_batman.tar.bz2" -C "$HOME/.icons/"
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
  chmod u+x "$DESKTOP/an_discord.desktop"
}

function copy_ssh {
  #ssh-keyscan github.com >> ~/.ssh/known_hosts
  mkdir ~/.ssh
  cp ~/net-home/ssh/* ~/.ssh/
  chmod 400 ~/.ssh/id_rsa*
}

function git_clone {
  if [ -d "$2" ]; then
    cd "$2" || exit
    git pull
    cd - || exit
  else
    git clone "$1" "$2"
  fi
}

function svn_clone {
  cd ~/Bureau || exit
  svn checkout --username "$USER" --password "svn!$USER" "$1"
  cd - || exit
}

function install_atom_theme {
  apm install "$1" "$2"
  sed -i -e "s/northem-dark-atom-ui/$1/g" -e "s/atom-monokai/$2/g" "$HOME/.atom/config.cson"
}

#alex
if echo "$USER" | grep -q "d16007062"; then
  xset m 3/2 3
  rm "$HOME/Bureau/"{chromium,blender,spotify}.desktop
  xfdesktop --arrange
  xdg-mime default firefox-esr.desktop text/html
  cp -f "$HOME/.local/share/applications/mimeapps.list" "$HOME/.config/"
  git config --global user.name "bohrin"
  git config --global user.email "alex.dejaegher@gmail.com"
  git config --global push.default simple
  copy_ssh
  git_clone "git@github.com:L0L022/projet_bash.git" "$HOME/Bureau/projet_bash" &
  git_clone "git@github.com:bohrin/Projet-C-.git" "$HOME/Bureau/Projet-C-" &
  install_atom_theme atom-dark-minimal-ui seti-syntax
  sed -i "s|^\"\*\":$|\"*\":\n  \"atom-dark-minimal-ui\":\n      colors:\n        customColor: \"#850404\"|g" "$HOME/.atom/config.cson"
  #install_cursor_batman
  add_english_things &
fi

#loic e
if echo "$USER" | grep -q "e16006130"; then
  xfconf-query -n -c xfwm4 -p /general/workspace_count -t int -s 4
  xfconf-query -n -c xfwm4 -p /general/click_to_focus -t bool -s false
  xfconf-query -n -c xfwm4 -p /general/focus_delay -t int -s 0
  bash "$HOME/net-home/start_git.bash"
  copy_ssh
  git_clone "git@github.com:L0L022/sem1_iut.git" "$HOME/Bureau/sem1_iut" &
  git_clone "git@github.com:L0L022/sem2_iut.git" "$HOME/Bureau/sem2_iut" &
  git_clone "git@github.com:L0L022/projet_bash.git" "$HOME/Bureau/projet_bash" &
  git_clone "git@github.com:L0L022/TheDarkSide.git" "$HOME/Bureau/TheDarkSide" &
  git_clone "git@github.com:L0L022/projet7.git" "$HOME/Bureau/projet7" &
  git_clone "git@github.com:L0L022/SuperProjetCPP.git" "$HOME/Bureau/SuperProjetCPP" &
  svn_clone "svn://a-pedagoarles-subversion.aix.univ-amu.fr/groupe1" &
  add_english_things &
  install_qt &
  install_boost &
fi

#hugo
if echo "$USER" | grep -q "d16002496"; then
  xfconf-query -n -c xfce4-panel -p /panels/panel-1/nrows -t int -s 1
  xfconf-query -n -c xfce4-panel -p /plugins/plugin-4/rows -t int -s 1
  xfconf-query -n -c xfwm4 -p /general/workspace_count -t int -s 1
  add_english_things &
fi

#leo
if echo "$USER" | grep -q "s16001821"; then
  xfconf-query -n -c xfwm4 -p /general/workspace_count -t int -s 4
  git config --global push.default simple
  git config --global user.email "leo.sudreau.sin@gmail.com"
  git config --global user.name "LinkIsACake"
  git_clone "https://github.com/LinkIsACake/IUT.git" "$HOME/Bureau/IUT" &
  git_clone "https://github.com/L0L022/SuperProjetCPP.git" "$HOME/Bureau/SuperProjetCPP" &
  svn_clone "svn://a-pedagoarles-subversion.aix.univ-amu.fr/groupe1" &
  install_boost &
  curl -so "$HOME/.cache/TheDarkSide/Warframe-Hydroid.jpg" "http://vignette4.wikia.nocookie.net/warframe/images/5/5d/Warframe-Hydroid.jpg"
  xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -t string -s "$HOME/.cache/TheDarkSide/Warframe-Hydroid.jpg"
fi

#loic l
if echo "$USER" | grep -q "l16002580"; then
  git config --global push.default simple
  git config --global user.email "loiclemouel98@gmail.com"
  git config --global user.name "loiclemouel"
  add_english_things &
fi

#martin
if echo "$USER" | grep -q "a16000520"; then
  add_english_things &
fi

#laurent
if echo "$USER" | grep -q "d16013526"; then
  git config --global push.default simple
  git config --global user.email "laurentdoiteau@free.fr"
  git config --global user.name "napoleon789789"
  git_clone "https://github.com/napoleon789789/IUT" "$HOME/Bureau/IUT" &
  add_english_things &
fi

#killian
if echo "$USER" | grep -q "w16003485"; then
  git config --global push.default simple
  git config --global user.email "killianwolfger@hotmail.fr"
  git config --global user.name "killian05000"
  git_clone "https://github.com/killian05000/Projet_cpp.git" "$HOME/Bureau/Projet_cpp" &
  git_clone "https://github.com/killian05000/pixelGalaxy.git" "$HOME/Bureau/pixelGalaxy" &
  git_clone "https://github.com/killian05000/warlockArena.git" "$HOME/Bureau/warlockArena" &
  add_english_things &
  install_qt &
fi

#remy
if echo "$USER" | grep -q "y16006432"; then
  git_clone "https://github.com/killian05000/Projet_cpp.git" "$HOME/Bureau/Projet_cpp" &
fi

#nassim
if echo "$USER" | grep -q "e16013387"; then
  svn_clone "svn://a-pedagoarles-subversion.aix.univ-amu.fr/groupe1" &
  install_boost &
fi

#tristan
if echo "$USER" | grep -q "m16020665"; then
  svn_clone "svn://a-pedagoarles-subversion.aix.univ-amu.fr/groupe1" &
  install_boost &
fi

#lucas
if echo "$USER" | grep -q "d16008614"; then
  svn_clone "svn://a-pedagoarles-subversion.aix.univ-amu.fr/groupe1" &
  install_boost &
fi

#nathan
if echo "$USER" | grep -q "m16016249"; then
  svn_clone "svn://a-pedagoarles-subversion.aix.univ-amu.fr/groupe1" &
  install_boost &
fi

#louis
# if echo "$USER" | grep -q "j16007553"; then
# fi
