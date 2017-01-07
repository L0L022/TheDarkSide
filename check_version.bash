#!/bin/bash

package_installed_version="$(cat "$HOME/.cache/the_dark_side/home_package_version")"
package_latest_version="$(git ls-remote --tags "https://github.com/L0L022/config_iut" | sed "s|.*refs/tags/\(.*\)$|\1|g" | sort -V | tail -n 1)"

if [[ "$package_latest_version" && "$package_installed_version" != "$package_latest_version" ]]; then
  if zenity --version >/dev/null 2>&1; then
    if zenity --title "The Dark Side" --question --icon-name "system-software-update" --text "Nouvelle version disponible : $package_latest_version.\nVoulez vous l'installer ?"; then
      bash "$HOME/.cache/the_dark_side/the_dark_side.bash"
    fi
  else
    notify-send -i "system-software-update" "The Dark Side" "Nouvelle version disponible : $package_latest_version \!\!\!"
  fi
fi
