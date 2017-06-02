#!/bin/bash

function feedback {
  zenity --title="$1" --height=400 --width=900 --ok-label=Fermer --cancel-label=Fermer --text-info --auto-scroll
}

function _download {
  echo "_____________________________________________TÉLÉCHARGEMENT_____________________________________________"
}

function _extract {
  echo "_______________________________________________EXTRACTION_______________________________________________"
}

function _config {
  echo "______________________________________________CONFIGURATION______________________________________________"
}

function _compilation {
  echo "_______________________________________________COMPILATION_______________________________________________"
}

function _install {
  echo "______________________________________________INSTALLATION______________________________________________"
}

function _finish {
  echo "_________________________________________________TERMINÉ_________________________________________________"
}

function check_install {
  if [ -d "$1" ]; then
    echo "_______________________________________INSTALLATION DÉJÀ PRÉSENTE_______________________________________"
    sleep 1
    if zenity --question --text="$2 est déjà installé. Voulez vous le réinstaller ?" > /dev/null 2>&1; then
      echo "________________________________SUPPRESSION DE L'ANCIENNE INSTALLATION________________________________"
      rm -rf "$1"
      rm -rf "$1-install"
      return 0
    else
      echo "_________________________________________INSTALLATION ANNULÉE_________________________________________"
      return 1
    fi
  fi
  return 0
}

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
  if check_install /var/tmp/boost boost; then
    old="$PWD"
    cd /var/tmp/ || exit

    _download
    curl -L -o boost.tar.bz2 "https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2"

    _extract
    tar xf boost.tar.bz2

    mv boost_1_64_0 boost
    cd boost || exit

    _config
    ./bootstrap.sh

    libs=(0 atomic 1 chrono 2 container 3 context 4 coroutine 5 coroutine2 6 date_time 7 exception 8 fiber 9 filesystem 10 graph 11 graph_parallel 12 iostreams 13 locale 14 log 15 math 16 metaparse 17 mpi 18 program_options 19 python 20 random 21 regex 22 serialization 23 signals 24 system 25 test 26 thread 27 timer 28 type_erasure 29 wave)
    selected="$(zenity --title="Installer boost" --window-icon=/usr/share/icons/Adwaita/48x48/apps/system-software-install.png --ok-label=Installer --list --checklist --multiple --hide-header --text="Sélectionner les bibliothèques boost à installer :" --column="" --column="Bibliothèques" "${libs[@]}")"

    if [ "$selected" ]; then
      _compilation
      ./b2 $(echo '|'$selected | sed "s/|/ --with-/g") --prefix=/var/tmp/boost-install install
    fi

    cd "$old" || exit
  fi
  _finish
}

function install_sfml {
  if check_install /var/tmp/sfml sfml; then
    old="$PWD"
    cd /var/tmp/ || exit

    _download
    #curl -L -o SFML-sources.zip "http://mirror2.sfml-dev.org/files/SFML-2.4.2-sources.zip"
    curl -L -o SFML.tar.bz2 "https://www.sfml-dev.org/files/SFML-2.1-linux-gcc-64bits.tar.bz2"

    _extract
    #unzip SFML-sources.zip
    tar xf SFML.tar.bz2

    mv -f SFML-2.1 sfml
    # cd sfml || exit
    # mkdir build
    # cd build || exit
    #
    # _config
    # cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/var/tmp/sfml-install
    #
    # _compilation
    # make -j4 all
    #
    # _install
    # make install

    cd "$old" || exit
  fi
  _finish
}

function install_cmake {
  if check_install /var/tmp/cmake cmake; then
    old="$PWD"
    cd /var/tmp/ || exit

    _download
    curl -L -o cmake.tar.gz "https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.tar.gz"

    _extract
    tar xf cmake.tar.gz

    mv -f cmake-3.8.2-Linux-x86_64 cmake

    cd "$old" || exit
  fi
  _finish
}

function install_entityx {
  if check_install /var/tmp/entityx entityx; then
    old="$PWD"
    cd /var/tmp/ || exit

    _download
    curl -L -o entityx.zip "https://github.com/alecthomas/entityx/archive/master.zip"

    _extract
    unzip entityx.zip

    mv -f entityx-master entityx
    cd entityx || exit
    mkdir build
    cd build || exit

    _config
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/var/tmp/entityx-install -DENTITYX_BUILD_TESTING=false -DENTITYX_BUILD_SHARED=false

    _compilation
    make -j4 all

    _install
    make install

    cd "$old" || exit
  fi
  _finish
}

libs=(0 "Qt" 5.8 1 "boost" 1.64.0 2 "SFML" 2.4.2 3 "CMake" 3.8.2 4 "EntityX" 1.X.X)
selected="$(zenity --title="Installer des bibliothèques" --window-icon=/usr/share/icons/Adwaita/48x48/apps/system-software-install.png --ok-label=Installer --height=300 --list --checklist --multiple --text="Sélectionner les bibliothèques à installer :" --column="" --column="Bibliothèques" --column="Version" "${libs[@]}")"
if echo "$selected" | grep -q "Qt"; then
  install_qt &
fi
if echo "$selected" | grep -q "boost"; then
  (install_boost 2>&1 | feedback "boost") &
fi
if echo "$selected" | grep -q "SFML"; then
  (install_sfml 2>&1 | feedback "SFML") &
fi
if echo "$selected" | grep -q "CMake"; then
  (install_cmake 2>&1 | feedback "CMake") &
fi
if echo "$selected" | grep -q "EntityX"; then
  (install_entityx 2>&1 | feedback "EntityX") &
fi
