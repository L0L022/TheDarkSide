#!/bin/bash

mkdir work
cd work || exit
mkdir home_copy log

function get_source {
	user_depo="$1"
	depo="$(basename "$user_depo")"
	github_url="https://github.com/$user_depo"
	last_release="$(git ls-remote --tags "$github_url" | sed "s|.*refs/tags/\(.*\)$|\1|g" | grep -v "beta" | grep -v "alpha" | sort -V | tail -n 1)"
	if [ -z "$last_release" ]; then
		last_release="master"
	fi
	echo "last_release=$last_release"
	if [ ! -f "$depo.tar.gz" ]; then
		wget -c -O "$depo.tar.gz" "$github_url/archive/$last_release.tar.gz"
	fi
	if [ -d "$depo" ]; then
		rm -r "$depo"
	fi
	mkdir "$depo"
	tar xzf "$depo.tar.gz" -C "$depo" --strip-components=1
}

function install_powerline_fonts {
	get_source "powerline/fonts"
	cd fonts || exit
	#HOME=../home_copy/ bash ./install.sh
	#from install.sh
	echo "Copying fonts..."
	find . \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0 | xargs -0 -I % cp "%" "../home_copy/.local/share/fonts/"
	cd ..
}

function install_font {
	mkdir -p home_copy/.local/share/fonts
	install_powerline_fonts
}

function install_arc_theme {
	#git clone https://github.com/horst3180/arc-theme --depth 1
	get_source "horst3180/arc-theme"
	cd arc-theme || exit
	mkdir install
	bash ./autogen.sh --with-gnome=3.14 --prefix="$(realpath ./install)"
	make install
	mv install/share/themes/* ../home_copy/.themes/
	cd ..
}

function install_theme {
	mkdir home_copy/.themes
	install_arc_theme
}

function install_faba_icon_theme {
	#git clone https://github.com/snwh/faba-icon-theme.git
	get_source "snwh/faba-icon-theme"
	cd faba-icon-theme || exit
	mkdir install
	bash ./autogen.sh --prefix="$(realpath ./install)"
	make
	make install DESTDIR="$(realpath ./install)"
	mv install/usr/share/icons/* ../home_copy/.icons/
	cd ..
}

function install_faba_mono_icon_theme {
	#git clone https://github.com/snwh/faba-mono-icons.git
	get_source "snwh/faba-mono-icons"
	cd faba-mono-icons || exit
	mkdir install
	bash ./autogen.sh --prefix="$(realpath ./install)"
	make
	make install
	mv install/share/icons/* ../home_copy/.icons/
	cd ..
}


function install_moka_icon_theme {
	#git clone https://github.com/moka-project/moka-icon-theme.git
	get_source "moka-project/moka-icon-theme"
	cd moka-icon-theme || exit
	mkdir install
	bash ./autogen.sh --prefix="$(realpath ./install)"
	make
	make install DESTDIR="$(realpath ./install)"
	rm -R install/usr/share/icons/Moka/{*@2x,256x256}
	mv install/usr/share/icons/* ../home_copy/.icons/
	cd ..
}

function install_arc_icon_theme {
	#git clone https://github.com/horst3180/arc-icon-theme --depth 1
	get_source "horst3180/arc-icon-theme"
	cd arc-icon-theme || exit
	mkdir install
	bash ./autogen.sh --prefix="$(realpath ./install)"
	make install
	mv install/share/icons/* ../home_copy/.icons/
	cd ..
}

function install_hacked_green {
	mkdir hacked_green
	cd hacked_green || exit
	wget -c -O Hacked-Green.tgz "https://www.dropbox.com/s/jzinbd7o5fnkzhi/Hacked-Green.tgz?dl=0#"
	tar xf Hacked-Green.tgz
	mv Hacked-Green ../home_copy/.icons/
	cd ..
}

function install_icon_theme {
	mkdir home_copy/.icons
	install_faba_icon_theme
	install_faba_mono_icon_theme
	install_moka_icon_theme
	install_arc_icon_theme

	install_hacked_green
}

function install_atom {
	mkdir -p "$TDS/atom"
	atom_version="$(git ls-remote --tags "https://github.com/atom/atom/" | sed "s|.*refs/tags/\(.*\)$|\1|g" | grep -v "beta" | sort -V | tail -n 1)"
	if [ ! -f "atom-amd64.tar.gz" ]; then
		wget -c "https://github.com/atom/atom/releases/download/$atom_version/atom-amd64.tar.gz"
	fi
	tar xf "atom-amd64.tar.gz"
	mv atom-*/* "$TDS/atom"

	cp "$TDS/atom/atom.png" home_copy/.local/share/icons/
	cp ../atom/atom.desktop home_copy/.local/share/applications/
}

function install_atom_packages {
	mkdir home_copy/.atom/
	ATOM_HOME="$(realpath home_copy/.atom/)"
	export ATOM_HOME
	"$TDS/atom/resources/app/apm/bin/apm" install --packages-file ../atom/atom-packages.txt

	#config files
	cp ../atom/config.cson ../atom/data-atom-connections.cson ../atom/toolbar.cson home_copy/.atom/

	patch home_copy/.atom/packages/flex-tool-bar/node_modules/tree-match-sync/index.js ../atom/tree-match-sync.patch
}

function install_shellcheck {
	mkdir shellcheck
	cd shellcheck || exit
	wget -c -O shellcheck.tar.xz http://mir.archlinux.fr/community/os/x86_64/shellcheck-0.4.6-2-x86_64.pkg.tar.xz
	tar xf shellcheck.tar.xz
	mv usr/bin/shellcheck "../$TDS/"
	chmod u+x "../$TDS/shellcheck"
	cd ..
}

function install_tree {
	mkdir tree
	cd tree || exit
	wget -c -O tree.deb "http://ftp.fr.debian.org/debian/pool/main/t/tree/tree_1.6.0-1_amd64.deb"
	ar x tree.deb data.tar.gz
	tar xf data.tar.gz
	mv usr/bin/tree "../$TDS/"
	chmod u+x "../$TDS/tree"
	cd ..
}

function install_dconf {
	mkdir dconf
	cd dconf || exit
	wget -c -O dconf.deb "http://ftp.fr.debian.org/debian/pool/main/d/d-conf/dconf-cli_0.22.0-1_amd64.deb"
	ar x dconf.deb data.tar.xz
	tar xf data.tar.xz
	mv usr/bin/dconf "../$TDS/"
	chmod u+x "../$TDS/dconf"
	cd ..
}

function install_terminix {
	wget -c -O Terminix.AppImage "https://bintray.com/probono/AppImages/download_file?file_path=Terminix-1.30-x86_64.AppImage"
	mv Terminix.AppImage "$TDS/"
	cp ../other/terminix.bash "$TDS/"
	chmod u+x "$TDS"/{Terminix.AppImage,terminix.bash}
	mkdir -p home_copy/.local/share/xfce4/helpers
	cp ../desktop/com.gexperts.Terminix.desktop home_copy/.local/share/applications/
	cp ../desktop/custom-TerminalEmulator.desktop home_copy/.local/share/xfce4/helpers/
	mkdir -p home_copy/.local/share/appimagekit
	touch home_copy/.local/share/appimagekit/no_desktopintegration
}

function install_tmux {
	mkdir tmux
	cd tmux || exit
	wget -c -O tmux.deb "http://ftp.fr.debian.org/debian/pool/main/t/tmux/tmux_2.3-4~bpo8+1_amd64.deb"
	ar x tmux.deb data.tar.xz
	tar xf data.tar.xz
	mv usr/bin/tmux "../$TDS/"
	chmod u+x "../$TDS/tmux"
	cd ..
}

function install_bash_it {
	git clone --depth=1 https://github.com/Bash-it/bash-it.git "$TDS/bash_it"
	HOME="$(realpath home_copy)" bash "$TDS/bash_it/install.sh" --silent --no-modify-config
}

function install_software {
	mkdir -p home_copy/.local/share/{applications,icons}
	install_atom
	install_atom_packages
	install_shellcheck
	install_tree
	install_dconf
	install_terminix
	install_tmux
	install_bash_it
}

cp ../other/bashrc home_copy/.bashrc
TDS=home_copy/.cache/TheDarkSide
mkdir -p "$TDS"
mkdir -p home_copy/.local/share/applications/

install_font &> log/font
install_theme &> log/theme
install_icon_theme &> log/icon_theme
install_software &> log/software

cp ../desktop/{TheDarkSide-volume,TheDarkSide-install-add-on,CMake}.desktop home_copy/.local/share/applications/
chmod u+x home_copy/.local/share/applications/*

mkdir -p home_copy/.config/autostart
cp ../autostart/TheDarkSide-check-version.desktop ../autostart/TheDarkSide-update.desktop home_copy/.config/autostart/

cp ../TheDarkSide.bash ../script/config-at-runtime.bash ../script/install-add-on.bash ../autostart/check-version.bash ../autostart/update.bash ../desktop/volume.bash ../desktop/linux_tux_by_linux4sa.jpg "$TDS/"
chmod u+x "$TDS"/{TheDarkSide,config-at-runtime,install-add-on,check-version,update,volume}.bash
tar -cJf package.tar.xz -C home_copy .
mv package.tar.xz ../
