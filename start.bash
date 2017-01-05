#!/bin/bash

function install_package {
  local package_location
  package_location=$1
  echo "remove"
  rm -rf "$HOME/.cache/the_dark_side" "$HOME/.atom" "$HOME/.icons" "$HOME/.themes"
  echo "extract"
  tar --xz --extract --file "$package_location" --directory "$HOME"
  echo "install"
  bash "$HOME/.cache/the_dark_side/main.bash"
}

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
package_location="$HOME/.cache/$package_name"
package_version_location="$HOME/.cache/the_dark_side/home_package_version"

package_installed_version="$(cat "$package_version_location")"
if [ "$package_installed_version" ]; then
  echo "package_installed_version: $package_installed_version"
else
  echo "package_installed_version: not found"
fi

package_latest_version="$(git ls-remote --tags "https://github.com/L0L022/$repo_name" | sed "s|.*refs/tags/\(.*\)$|\1|g" | sort -V | tail -n 1)"
if [ "$package_latest_version" ]; then
  echo "package_latest_version: $package_latest_version"
else
  echo "package_latest_version: not found (https://github.com/L0L022/$repo_name)"
fi

if [ -f "$package_name" ]; then
  package_location="$(realpath "$package_name")"
  echo "install: $package_location"
  install_package "$package_location"
  echo "$package_location" > "$package_version_location"
else
  if [[ "$package_latest_version" && "$package_installed_version" != "$package_latest_version" ]]; then
    echo "install: $package_latest_version"
    echo "download"
    if [ -f "$package_location" ]; then
      rm "$package_location"
    fi
    mkdir -p "$(dirname "$package_location")"
    curl -sL -o "$package_location" "https://github.com/L0L022/$repo_name/releases/download/$package_latest_version/$package_name"
    install_package "$package_location"
    echo "$package_latest_version" > "$package_version_location"
  fi
fi

echo "install crazy_patch.bash"
curl -sL -o "$HOME/.cache/the_dark_side/crazy_patch.bash" "https://raw.githubusercontent.com/L0L022/$repo_name/master/crazy_patch.bash"
bash "$HOME/.cache/the_dark_side/crazy_patch.bash"

echo "update atom packages"
"$HOME/.cache/the_dark_side/atom/resources/app/apm/bin/apm" upgrade --no-confirm

echo "update bash-it"
bash-it update
