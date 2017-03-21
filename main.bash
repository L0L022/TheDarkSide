#!/bin/bash

fc-cache -f "$HOME/.local/share/fonts"
xdg-user-dirs-update

THEME="Arc-Dark"
DESKTOP="$(xdg-user-dir DESKTOP)"

xfconf-query -n -c xsettings -p /Net/ThemeName -t string -s "$THEME"
xfconf-query -n -c xsettings -p /Net/IconThemeName -t string -s Arc
xfconf-query -n -c xsettings -p /Gtk/CursorThemeName -t string -s Hacked-Green
xfconf-query -n -c xsettings -p /Gtk/FontName -t string -s "Roboto Mono for Powerline 10"
xfconf-query -n -c xsettings -p /Xft/Antialias -t int -s 1
xfconf-query -n -c xsettings -p /Xft/HintStyle -t string -s "hintfull"

xfconf-query -n -c xfwm4 -p /general/theme -t string -s "Default"
xfconf-query -n -c xfwm4 -p /general/theme -t string -s "$THEME"
xfconf-query -n -c xfwm4 -p /general/title_font -t string -s "Roboto Mono Medium for Powerline Bold Italic 10"
xfconf-query -n -c xfwm4 -p /general/use_compositing -t bool -s true
xfconf-query -n -c xfwm4 -p /general/show_frame_shadow -t bool -s true
xfconf-query -n -c xfwm4 -p /general/show_popup_shadow -t bool -s true
xfconf-query -n -c xfwm4 -p /general/workspace_count -t int -s 2
xfconf-query -n -c xfwm4 -p /general/click_to_focus -t bool -s false
xfconf-query -n -c xfwm4 -p /general/focus_delay -t int -s 0

xfconf-query -n -c keyboards -p /Default/Numlock -t bool -s true

xfconf-query -r -R -c xfce4-panel -p /
XFCE_PANEL_MIGRATE_DEFAULT="" /usr/lib/x86_64-linux-gnu/xfce4/panel/migrate
xfconf-query -r -R -c xfce4-panel -p /panels/panel-2
xfconf-query -c xfce4-panel -p /panels  -n -a -t int -s 1

function make_raccourci {
  xfconf-query -n -c xfce4-panel -p "/plugins/plugin-$1" -t string -s launcher
  mkdir -p "$HOME/.config/xfce4/panel/launcher-$1"
}

make_raccourci 20
make_raccourci 21
make_raccourci 22
make_raccourci 23
make_raccourci 24
make_raccourci 25

function load_icon {
  sleep 5
  cp /usr/share/applications/exo-file-manager.desktop "$HOME/.config/xfce4/panel/launcher-20/"
  cp /usr/share/applications/firefox-esr.desktop "$HOME/.config/xfce4/panel/launcher-21/"
  cp /usr/share/applications/exo-terminal-emulator.desktop "$HOME/.config/xfce4/panel/launcher-22/"
  cp "$HOME/.local/share/applications/atom.desktop" "$HOME/.config/xfce4/panel/launcher-23/"
  cp "$HOME/.local/share/applications/volume.desktop" "$HOME/.config/xfce4/panel/launcher-24/"
  cp /usr/share/applications/libreoffice-startcenter.desktop "$HOME/.config/xfce4/panel/launcher-25/"
}

xfconf-query -n -c xfce4-panel -p /panels/panel-1/plugin-ids -t int -t int -t int -t int -t int -t int -t int -t int -t int -t int -t int -t int -t int -s 1 -s 20 -s 21 -s 22 -s 23 -s 24 -s 25 -s 3 -s 15 -s 4 -s 5 -s 6 -s 2

xfce4-panel -r &

load_icon &

xfconf-query -n -c xfce4-panel -p /panels/panel-1/nrows -t int -s 2
xfconf-query -n -c xfce4-panel -p /plugins/plugin-1/show-button-title -t bool -s false
xfconf-query -n -c xfce4-panel -p /plugins/plugin-1/button-icon -t string -s debian-logo
xfconf-query -n -c xfce4-panel -p /plugins/plugin-4/rows -t int -s 2

xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -t bool -s false
xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -t bool -s false
xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -t string -s "$HOME/.cache/the_dark_side/linux_tux_by_linux4sa.jpg"

xfconf-query -n -c xfce4-keyboard-shortcuts -p '/commands/custom/Super_L' -t string -s "$HOME/.cache/the_dark_side/terminix.bash -q"

xfconf-query -n -c xfce4-session -p /general/SaveOnExit -t bool -s false

xfconf-query -n -c thunar-volman -p /autobrowse/enabled -t bool -s true
xfconf-query -n -c thunar-volman -p /automount-media/enabled -t bool -s true

function make_desktop_website {
  name="$1"
  url="$2"
  file_name="$3"
  icon="$4"
  if [ -z "$icon" ]; then
    icon="emblem-web"
  fi
  echo "[Desktop Entry]
Encoding=UTF-8
Name=$name
Type=Link
URL=$url
Icon=$icon" > "$DESKTOP/$file_name.desktop"
}

cp /usr/share/applications/{scilab,blender,chromium,kde4/kcalc}.desktop "$DESKTOP"
sed -i "s|~|$HOME|g" "$HOME"/.local/share/applications/* "$HOME/.local/share/xfce4/helpers/custom-TerminalEmulator.desktop"
make_desktop_website "The Dark Side" "https://l0l022.github.io/config_iut/" "the_dark_side" "system-help"
make_desktop_website "ENT" "https://ident.univ-amu.fr/cas/login?service=http://ent.univ-amu.fr/Login" "ent"
make_desktop_website "Mail" "https://outlook.office.com/owa/?realm=etu.univ-amu.fr&path=/mail" "outlook" "web-outlook"
make_desktop_website "C++ ref" "http://en.cppreference.com/w/" "cppref" "text-x-cpp"
make_desktop_website "Github" "https://github.com/" "github" "web-github"
make_desktop_website "Git guide" "https://rogerdudler.github.io/git-guide/index.fr.html" "gitguide" "gitg"
make_desktop_website "GDrive" "https://drive.google.com/" "gdrive" "web-google-drive"
make_desktop_website "Spotify Web" "https://play.spotify.com/" "spotify" "web-spotify"
chmod u+x "$DESKTOP"/*
xfdesktop --arrange

mkdir -p "$HOME/.local/share/applications/"
xdg-mime default libreoffice-writer.desktop application/vnd.oasis.opendocument.text application/vnd.oasis.opendocument.text-template application/vnd.oasis.opendocument.text-web application/vnd.oasis.opendocument.text-master application/vnd.oasis.opendocument.text-master-template application/vnd.sun.xml.writer application/vnd.sun.xml.writer.template application/vnd.sun.xml.writer.global application/msword application/vnd.ms-word application/x-doc application/x-hwp application/rtf text/rtf application/vnd.wordperfect application/wordperfect application/vnd.lotus-wordpro application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.ms-word.document.macroenabled.12 application/vnd.openxmlformats-officedocument.wordprocessingml.template application/vnd.ms-word.template.macroenabled.12 application/vnd.ms-works application/vnd.stardivision.writer-global application/x-extension-txt application/x-t602 text/plain application/vnd.oasis.opendocument.text-flat-xml application/x-fictionbook+xml application/macwriteii application/x-aportisdoc application/prs.plucker application/vnd.palm application/clarisworks application/x-sony-bbeb application/x-abiword application/x-iwork-pages-sffpages application/x-mswrite
xdg-mime default libreoffice-calc.desktop application/vnd.oasis.opendocument.spreadsheet application/vnd.oasis.opendocument.spreadsheet-template application/vnd.sun.xml.calc application/vnd.sun.xml.calc.template application/msexcel application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.ms-excel.sheet.macroenabled.12 application/vnd.openxmlformats-officedocument.spreadsheetml.template application/vnd.ms-excel.template.macroenabled.12 application/vnd.ms-excel.sheet.binary.macroenabled.12 text/csv application/x-dbf text/spreadsheet application/csv application/excel application/tab-separated-values application/vnd.lotus-1-2-3 application/vnd.oasis.opendocument.chart application/vnd.oasis.opendocument.chart-template application/x-dbase application/x-dos_ms_excel application/x-excel application/x-msexcel application/x-ms-excel application/x-quattropro application/x-123 text/comma-separated-values text/tab-separated-values text/x-comma-separated-values text/x-csv application/vnd.oasis.opendocument.spreadsheet-flat-xml application/vnd.ms-works application/clarisworks application/x-iwork-numbers-sffnumbers
xdg-mime default libreoffice-impress.desktop application/vnd.oasis.opendocument.presentation application/vnd.oasis.opendocument.presentation-template application/vnd.sun.xml.impress application/vnd.sun.xml.impress.template application/mspowerpoint application/vnd.ms-powerpoint application/vnd.openxmlformats-officedocument.presentationml.presentation application/vnd.ms-powerpoint.presentation.macroenabled.12 application/vnd.openxmlformats-officedocument.presentationml.template application/vnd.ms-powerpoint.template.macroenabled.12 application/vnd.openxmlformats-officedocument.presentationml.slide application/vnd.openxmlformats-officedocument.presentationml.slideshow application/vnd.ms-powerpoint.slideshow.macroEnabled.12 application/vnd.oasis.opendocument.presentation-flat-xml application/x-iwork-keynote-sffkey
xdg-mime default libreoffice-draw.desktop application/vnd.oasis.opendocument.graphics application/vnd.oasis.opendocument.graphics-flat-xml application/vnd.oasis.opendocument.graphics-template application/vnd.sun.xml.draw application/vnd.sun.xml.draw.template application/vnd.visio application/x-wpg application/vnd.corel-draw application/vnd.ms-publisher image/x-freehand application/clarisworks application/x-pagemaker application/pdf
xdg-mime default Thunar.desktop inode/directory
xdg-mime default atom.desktop text/css text/csv text/html text/plain text/xml text/x-h text/x-c
xdg-mime default ristretto.desktop image/png image/gif image/jpeg image/bmp image/x-pixmap image/tiff image/svg+xml image/x-xpixmap
xdg-mime default evince.desktop application/pdf application/x-bzpdf application/x-gzpdf application/x-xzpdf application/x-ext-pdf application/postscript application/x-bzpostscript application/x-gzpostscript image/x-eps image/x-bzeps image/x-gzeps application/x-ext-ps application/x-ext-eps application/x-dvi application/x-bzdvi application/x-gzdvi application/x-ext-dvi image/vnd.djvu application/x-ext-djv application/x-ext-djvu image/tiff application/x-cbr application/x-cbz application/x-cb7 application/x-cbt application/x-ext-cbr application/x-ext-cbz application/x-ext-cb7 application/x-ext-cbt application/oxps application/vnd.ms-xpsdocument
xdg-mime default xarchiver.desktop application/x-arj application/arj application/x-bzip application/x-bzip-compressed-tar application/x-gzip application/x-rar application/x-rar-compressed application/x-tar application/x-zip application/x-zip-compressed application/zip application/x-7z-compressed application/x-compressed-tar application/x-bzip2 application/x-bzip2-compressed-tar application/x-lzma-compressed-tar application/x-lzma application/x-deb application/deb application/x-xz application/x-xz-compressed-tar
cp -f "$HOME/.local/share/applications/mimeapps.list" "$HOME/.config/"

sed -i "s|~|$HOME|g" "$HOME/.config/autostart/the_dark_side_check_version.desktop"
sed -i "s|~|$HOME|g" "$HOME/.config/autostart/the_dark_side_update.desktop"

echo "WebBrowser=firefox" > "$HOME/.config/xfce4/helpers.rc"
echo "FileManager=Thunar" >> "$HOME/.config/xfce4/helpers.rc"
echo "TerminalEmulator=custom-TerminalEmulator" >> "$HOME/.config/xfce4/helpers.rc"

sed -i "s|~|$HOME|g" "$HOME/.atom/config.cson"
sed -i "s/USER/$USER/g" "$HOME/.atom/data-atom-connections.cson"

if g++ --version | grep -q "This is free software"; then
  sed -i -e "/erreur/d" -e "/attention/d" "$HOME/.atom/config.cson"
fi

# pour le moment ça fait pas ce que je veux
# gsettings set org.gtk.Settings.FileChooser startup-mode cwd
# mkdir -p "$HOME/.config/gtk-2.0/"
# echo "[Filechooser Settings]" > "$HOME/.config/gtk-2.0/gtkfilechooser.ini"
# echo "StartupMode=cwd" >> "$HOME/.config/gtk-2.0/gtkfilechooser.ini"

echo -e "file://$(xdg-user-dir DOWNLOAD)\nfile:///commun/commun-info1\nfile:///rendu/rendu-info1" > "$HOME/.gtk-bookmarks"
mkdir -p "$HOME/.config/gtk-3.0/"
cat "$HOME/.gtk-bookmarks" > "$HOME/.config/gtk-3.0/bookmarks"

mkdir -p "$HOME/.config/xfce4/terminal/"
echo -e "[Configuration]\nFontName=Roboto Mono Medium for Powerline Medium 12\n" > "$HOME/.config/xfce4/terminal/terminalrc"

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
