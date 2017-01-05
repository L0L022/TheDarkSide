#!/bin/bash

THEME="Arc-Dark"
DESKTOP="$(xdg-user-dir DESKTOP)"

xfconf-query -n -c xsettings -p /Net/ThemeName -t string -s "$THEME"
xfconf-query -n -c xsettings -p /Net/IconThemeName -t string -s Arc

xfconf-query -n -c xfwm4 -p /general/theme -t string -s "$THEME"
xfconf-query -n -c xfwm4 -p /general/use_compositing -t bool -s true
xfconf-query -n -c xfwm4 -p /general/show_frame_shadow -t bool -s true
xfconf-query -n -c xfwm4 -p /general/show_popup_shadow -t bool -s true
xfconf-query -n -c xfwm4 -p /general/workspace_count -t int -s 2

xfconf-query -n -c keyboards -p /Default/Numlock -t bool -s true

xfconf-query -r -R -c xfce4-panel -p /
XFCE_PANEL_MIGRATE_DEFAULT="" /usr/lib/x86_64-linux-gnu/xfce4/panel/migrate
xfce4-panel -r &
xfconf-query -n -c xfce4-panel -p /panels/panel-1/nrows -t int -s 2
xfconf-query -n -c xfce4-panel -p /panels/panel-2/autohide -t bool -s true
xfconf-query -n -c xfce4-panel -p /plugins/plugin-1/show-button-title -t bool -s false
xfconf-query -n -c xfce4-panel -p /plugins/plugin-1/button-icon -t string -s debian-logo
xfconf-query -n -c xfce4-panel -p /plugins/plugin-4/rows -t int -s 2

xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -t bool -s false
xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -t bool -s false

xfconf-query -n -c xfce4-keyboard-shortcuts -p '/commands/custom/Super_L' -t string -s "$HOME/.cache/the_dark_side/terminix.bash -q"

xfconf-query -n -c xfce4-session -p /general/SaveOnExit -t bool -s false

xfconf-query -n -c thunar-volman -p /autobrowse/enabled -t bool -s true
xfconf-query -n -c thunar-volman -p /automount-media/enabled -t bool -s true

xdg-user-dirs-update
cp /usr/share/applications/{firefox-esr,libreoffice-startcenter,scilab,chromium,kde4/kcalc,exo-terminal-emulator}.desktop "$DESKTOP"
sed -i "s|~|$HOME|g" "$HOME"/.local/share/applications/* "$HOME/.local/share/xfce4/helpers/custom-TerminalEmulator.desktop"
cp "$HOME/.local/share/applications/atom.desktop" "$DESKTOP"
cp "$HOME/.cache/the_dark_side/the_dark_side.desktop" "$DESKTOP"
chmod u+x "$DESKTOP"/*

mkdir -p "$HOME/.local/share/applications/"
xdg-mime default Thunar.desktop inode/directory
xdg-mime default atom.desktop text/css text/csv text/html text/plain text/xml text/x-h text/x-c
xdg-mime default ristretto.desktop image/png image/gif image/jpeg image/bmp image/x-pixmap image/tiff image/svg+xml image/x-xpixmap
xdg-mime default evince.desktop application/pdf application/x-bzpdf application/x-gzpdf application/x-xzpdf application/x-ext-pdf application/postscript application/x-bzpostscript application/x-gzpostscript image/x-eps image/x-bzeps image/x-gzeps application/x-ext-ps application/x-ext-eps application/x-dvi application/x-bzdvi application/x-gzdvi application/x-ext-dvi image/vnd.djvu application/x-ext-djv application/x-ext-djvu image/tiff application/x-cbr application/x-cbz application/x-cb7 application/x-cbt application/x-ext-cbr application/x-ext-cbz application/x-ext-cb7 application/x-ext-cbt application/oxps application/vnd.ms-xpsdocument
xdg-mime default xarchiver.desktop application/x-arj application/arj application/x-bzip application/x-bzip-compressed-tar application/x-gzip application/x-rar application/x-rar-compressed application/x-tar application/x-zip application/x-zip-compressed application/zip application/x-7z-compressed application/x-compressed-tar application/x-bzip2 application/x-bzip2-compressed-tar application/x-lzma-compressed-tar application/x-lzma application/x-deb application/deb application/x-xz application/x-xz-compressed-tar
cp -f "$HOME/.local/share/applications/mimeapps.list" "$HOME/.config/"

sed -i "s|~|$HOME|g" "$HOME/.config/autostart/the_dark_side_check_version.desktop"

echo "WebBrowser=firefox" > "$HOME/.config/xfce4/helpers.rc"
echo "FileManager=Thunar" >> "$HOME/.config/xfce4/helpers.rc"
echo "TerminalEmulator=custom-TerminalEmulator" >> "$HOME/.config/xfce4/helpers.rc"

sed -i "s|~|$HOME|g" "$HOME/.atom/config.cson"
sed -i "s/USER/$USER/g" "$HOME/.atom/data-atom-connections.cson"

if g++ --version | grep -q "This is free software"; then
  sed -i -e "/erreur/d" -e "/attention/d" "$HOME/.atom/config.cson"
fi

gsettings set org.gtk.Settings.FileChooser startup-mode cwd
mkdir -p "$HOME/.config/gtk-2.0/"
echo "[Filechooser Settings]" > "$HOME/.config/gtk-2.0/gtkfilechooser.ini"
echo "StartupMode=cwd" >> "$HOME/.config/gtk-2.0/gtkfilechooser.ini"

fc-cache -f "$HOME/.local/share/fonts"

source "$HOME/.bashrc"
function with_new_bashrc {
  dconf write /com/gexperts/Terminix/quake-height-percent 50
  dconf write /com/gexperts/Terminix/profiles/the_dark_side/visible-name "'The Dark Side'"
  dconf write /com/gexperts/Terminix/profiles/list "['the_dark_side']"
  dconf write /com/gexperts/Terminix/profiles/default "'the_dark_side'"
  dconf write /com/gexperts/Terminix/profiles/the_dark_side/font "'Roboto Mono Medium for Powerline Medium 12'"
  dconf write /com/gexperts/Terminix/profiles/the_dark_side/use-system-font false
  dconf write /com/gexperts/Terminix/profiles/the_dark_side/terminal-bell "'icon'"
  dconf write /com/gexperts/Terminix/profiles/the_dark_side/cursor-shape "'underline'"

  bash-it enable plugin alias-completion base dirs extract git git-subrepo history proxy ssh tmux xterm
  bash-it enable completion bash-it defaults dirs git makefile ssh system tmux
  reload
}
bash -i -c "#$(type with_new_bashrc);with_new_bashrc"
