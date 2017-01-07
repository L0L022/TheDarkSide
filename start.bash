#!/bin/bash

function set_variables {
  if curl -sL "https://github.com/L0L022/the_dark_side" | grep "html"; then
    repo_name="the_dark_side"
    sed -i "s/config_iut/the_dark_side/g" "start_web.bash"
    mv "start_web.bash" "the_dark_side.bash"
    sed -i "s/config_iut/the_dark_side/g" "the_dark_side.bash"
  else
    repo_name="config_iut"
  fi
  echo "repo_name: $repo_name"

  package_name="home_package.tar.xz"
  package_dir="$HOME/.cache"
  if [ -w "/var/tmp/" ]; then
    package_dir="/var/tmp"
  fi
  package_location="$package_dir/$package_name"
  package_version_location="$package_dir/home_package_version"
  package_installed_version_location="$HOME/.cache/the_dark_side/home_package_version"

  package_version="$(cat "$package_version_location")"
  if [ -z "$package_version" ]; then
    package_version="not found"
  fi
  echo "package_version: $package_version"

  package_installed_version="$(cat "$package_installed_version_location")"
  if [ -z "$package_installed_version" ]; then
    package_installed_version="not found"
  fi
  echo "package_installed_version: $package_installed_version"

  package_latest_version="$(git ls-remote --tags "https://github.com/L0L022/$repo_name" | sed "s|.*refs/tags/\(.*\)$|\1|g" | sort -V | tail -n 1)"
  if [ -z "$package_latest_version" ]; then
    package_latest_version="not found"
  fi
  echo "package_latest_version: $package_latest_version"
}

function install_pv {
  if ! pv -V >/dev/null 2>&1; then
    echo "install pv"
    old_dir="$PWD"
    mkdir -p /tmp/pv
    cd /tmp/pv || exit
    curl -sL -o pv.deb "http://ftp.fr.debian.org/debian/pool/main/p/pv/pv_1.5.7-2_amd64.deb"
    ar x pv.deb data.tar.xz
    tar xf data.tar.xz
    cd "$old_dir" || exit
  fi
}

function install_package {
  echo "install: $install_version"
  echo "remove"
  rm -rf "$HOME/.cache/the_dark_side" "$HOME/.atom" "$HOME/.icons" "$HOME/.themes"
  if [ "$use_gui" = true ]; then
    install_pv
    echo "extract"
    (/tmp/pv/usr/bin/pv -n "$package_location" | tar xJf - -C "$HOME") 2>&1
  else
    echo "extract"
    tar xf "$package_location" -C "$HOME"
  fi
  echo "install"
  bash "$HOME/.cache/the_dark_side/main.bash"
  echo "$install_version" > "$package_installed_version_location"
}

function install {
  mkdir -p "$package_dir"
  if [ -f "$package_name" ]; then
    package_location="$(realpath "$package_name")"
    install_version="$package_location"
    install_package
  else
    if [[ "$package_latest_version" != "not found" && "$package_installed_version" != "$package_latest_version" ]]; then
      if [[ "$package_version" != "$package_latest_version" || ! -f "$package_location" ]]; then
        echo "download"
        if [ -f "$package_location" ]; then
          rm "$package_location"
        fi
        curl -L -o "$package_location" "https://github.com/L0L022/$repo_name/releases/download/$package_latest_version/$package_name"
        chmod 666 "$package_location"
        echo "$package_latest_version" > "$package_version_location"
        chmod 666 "$package_version_location"
      fi
      install_version="$package_latest_version"
      install_package
    fi
  fi
}

function update {
  bash -i "$HOME/.cache/the_dark_side/update.bash"
}

if zenity --version >/dev/null 2>&1; then
  use_gui=true
  (
    echo "#[1/5] Recherche des différentes versions"
    set_variables
    install 2>&1 | stdbuf -oL tr '\r' '\n' | sed -u \
    -e "s|^install: .*|0\n#Installation de la version : $package_latest_version|g" \
    -e "s|^remove$|0\n#[3\/5]($package_installed_version -> $package_latest_version) Désinstallation|g" \
    -e "s|^install pv$|[4\/5]($package_installed_version -> $package_latest_version) Installation de pv|g" \
    -e "s|^extract$|0\n#[4\/5]($package_installed_version -> $package_latest_version) Mise en place des fichiers|g" \
    -e "s|^install$|0\n#[5\/5]($package_installed_version -> $package_latest_version) Installation|g" \
    -e "s|^ *\([0-9][0-9]*\).*\( [0-9].*$\)|\1\n#[2\/5]($package_installed_version -> $package_latest_version) Téléchargement \2\/s|g"
    echo -e "0\n#[0\/2]($package_installed_version -> $package_latest_version) Mise à jour"
    update | sed -u \
    -e "s|^install crazy_patch.bash$|0\n#[1\/3] Installation du crazy_patch|g" \
    -e "s|^update atom packages$|0\n#[2\/3] Mise à jour des paquets atom (peut être long)|g" \
    -e "s|^update bash-it$|0\n#[3\/3] Mise à jour de bash-it|g"
    echo -e "100\n#Installation terminée ($package_latest_version)"
  ) | zenity --progress --no-cancel --title "The Dark Side" --ok-label "Cacher" --width 600
else
  set_variables
  install
  update
fi
