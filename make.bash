#!/bin/bash

mkdir work
cd work || exit
mkdir home_copy

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

function install_arc_theme {
	#git clone https://github.com/horst3180/arc-theme --depth 1
	get_source "horst3180/arc-theme"
	cd arc-theme || exit
	mkdir install
	bash ./autogen.sh --with-gnome=3.14 --prefix="$(realpath ./install)"
	make install
	mkdir ../home_copy/.themes
	mv install/share/themes/* ../home_copy/.themes/
	cd ..
}

function install_theme {
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
	mkdir ../home_copy/.icons
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
	mkdir ../home_copy/.icons
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
	mkdir ../home_copy/.icons
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
	mkdir ../home_copy/.icons
	mv install/share/icons/* ../home_copy/.icons/
	cd ..
}

function install_icon_theme {
	install_faba_icon_theme
	install_faba_mono_icon_theme
	install_moka_icon_theme
	install_arc_icon_theme
}

function install_atom {
	atom_version="$(git ls-remote --tags "https://github.com/atom/atom/" | sed "s|.*refs/tags/\(.*\)$|\1|g" | grep -v "beta" | sort -V | tail -n 1)"
	mkdir -p home_copy/.cache/the_dark_side/atom
	if [ ! -f "atom-amd64.tar.gz" ]; then
		wget -c "https://github.com/atom/atom/releases/download/$atom_version/atom-amd64.tar.gz"
	fi
	tar -zxf "atom-amd64.tar.gz"
	mv atom-*/* home_copy/.cache/the_dark_side/atom

	mkdir -p home_copy/.local/share/{applications,icons}
	cp home_copy/.cache/the_dark_side/atom/atom.png home_copy/.local/share/icons/
	cp ../atom.desktop home_copy/.local/share/applications/
	chmod u+x home_copy/.local/share/applications/
}

function install_atom_packages {
	mkdir -p home_copy/.atom/
	ATOM_HOME="$(realpath home_copy/.atom/)"
	export ATOM_HOME
	home_copy/.cache/the_dark_side/atom/resources/app/apm/bin/apm install --packages-file ../atom-packages.txt

	#config files
	cp ../config.cson ../data-atom-connections.cson home_copy/.atom/
	patch home_copy/.atom/packages/linter-gcc/lib/main.js ../linter-gcc-french.patch
}

function install_shellcheck {
	mkdir shellcheck
	cd shellcheck || exit
	wget -c -O shellcheck.tar.xz http://mir.archlinux.fr/community/os/x86_64/shellcheck-0.4.5-1-x86_64.pkg.tar.xz
	tar -xf shellcheck.tar.xz
	mkdir -p ../home_copy/.cache/the_dark_side/
	mv usr/bin/shellcheck ../home_copy/.cache/the_dark_side/
	chmod u+x ../home_copy/.cache/the_dark_side/shellcheck
	cd ..
}

function install_terminix {
	wget -c -O Terminix.AppImage "https://bintray.com/probono/AppImages/download_file?file_path=Terminix-1.30-x86_64.AppImage"
	mv Terminix.AppImage ../terminix.bash home_copy/.cache/the_dark_side/
	chmod u+x home_copy/.cache/the_dark_side/{Terminix.AppImage,terminix.bash}
	mkdir -p home_copy/.local/share/applications home_copy/.local/share/xfce4/helpers
	cp ../com.gexperts.Terminix.desktop home_copy/.local/share/applications/
	cp ../custom-TerminalEmulator.desktop home_copy/.local/share/xfce4/helpers/
}

function install_software {
	install_atom
	install_atom_packages
	install_shellcheck
	install_terminix
}

install_theme
install_icon_theme
install_software

mkdir -p home_copy/.config/autostart
cp ../the_dark_side_check_version.desktop home_copy/.config/autostart/

cp ../main.bash ../the_dark_side.desktop ../check_version.bash home_copy/.cache/the_dark_side/
tar -cJf home_package.tar.xz -C home_copy .
mv home_package.tar.xz ../
