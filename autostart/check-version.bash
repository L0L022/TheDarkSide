#!/bin/bash

package_installed_version="$(cat "$TDS/current-package-version")"
package_latest_version="$(git ls-remote --tags "https://github.com/L0L022/TheDarkSide" | sed "s|.*refs/tags/\(.*\)$|\1|g" | sort -V | tail -n 1)"

if [[ "$package_latest_version" && "$package_installed_version" != "$package_latest_version" ]]; then
  if zenity --version >/dev/null 2>&1; then
    if zenity --title "The Dark Side" --question --icon-name "system-software-update" --text "Nouvelle version disponible : $package_latest_version.\nVoulez vous l'installer ?"; then
      bash "$TDS/TheDarkSide.bash"
    fi
  else
    notify-send -i "system-software-update" "The Dark Side" "Nouvelle version disponible : $package_latest_version \!\!\!"
  fi
fi
