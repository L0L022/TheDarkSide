#!/bin/bash
#mettre des trucs débiles

function wallpaper_ilovebash {
  curl -so "$HOME/.cache/the_dark_side/i-love-bash.zip" http://www.tux-planet.fr/public/images/wallpapers/linux/shell/i-love-bash.zip
  unzip -o "$HOME/.cache/the_dark_side/i-love-bash.zip" -d "$HOME/.cache/the_dark_side/"
  rm "$HOME/.cache/the_dark_side/i-love-bash.zip"
  xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -t string -s "$HOME/.cache/the_dark_side/i-love-bash/ILoveBash_1920x1200.png"
}

function copy_ssh {
  mkdir ~/.ssh
  cp ~/net-home/ssh/* ~/.ssh/
  chmod 400 ~/.ssh/id_rsa*
}

function install_atom_theme {
  apm install "$1" "$2"
  sed -i -e "s/northem-dark-atom-ui/$1/g" -e "s/atom-monokai/$2/g" "$HOME/.atom/config.cson"
}

if echo "$USER" | grep -q "d16007062"; then
  rm /home/d16007062/Bureau/{chromium,blender}.desktop
  xfdesktop --arrange
  xdg-mime default firefox-esr.desktop text/html
  cp -f "$HOME/.local/share/applications/mimeapps.list" "$HOME/.config/"
  git config --global user.name "bohrin"
  git config --global user.email "alex.dejaegher@gmail.com"
  git config --global push.default simple
  copy_ssh
  #ssh-keyscan github.com >> ~/.ssh/known_hosts
  git clone git@github.com:L0L022/projet_bash.git "$HOME/Bureau/projet_bash"
  install_atom_theme seti-ui seti-syntax
fi

if echo "$USER" | grep -q "e16006130"; then
  bash "$HOME/net-home/start_git.bash"
  copy_ssh
  #ssh-keyscan github.com >> ~/.ssh/known_hosts
  git clone git@github.com:L0L022/sem1_iut.git "$HOME/Bureau/sem1_iut"
  git clone git@github.com:L0L022/projet_bash.git "$HOME/Bureau/projet_bash"

  wget -O ~/Bureau/KDevelop.AppImage http://download.kde.org/stable/kdevelop/5.0.3/bin/linux/KDevelop-5.0.3-x86_64.AppImage
  chmod +x ~/Bureau/KDevelop.AppImage
fi

if echo "$USER" | grep -q "d16002496"; then
  xfconf-query -n -c xfce4-panel -p /panels/panel-1/nrows -t int -s 1
  xfconf-query -n -c xfce4-panel -p /plugins/plugin-4/rows -t int -s 1
  xfconf-query -n -c xsettings -p /Net/ThemeName -t string -s Adwaita
  xfconf-query -n -c xsettings -p /Net/IconThemeName -t string -s Moka
  xfconf-query -n -c xfwm4 -p /general/theme -t string -s Arc
  install_atom_theme atom-material-ui atom-material-syntax-light
fi
