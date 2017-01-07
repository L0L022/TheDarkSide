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

function install_powerline_fonts {
	get_source "powerline/fonts"
	cd fonts || exit
	#HOME=../home_copy/ bash ./install.sh
	#from install.sh
	powerline_fonts_dir=$( cd "$( dirname "$0" )" && pwd )
	find_command="find \"$powerline_fonts_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"
	font_dir="../home_copy/.local/share/fonts"
	mkdir -p $font_dir
	echo "Copying fonts..."
	eval $find_command | xargs -0 -I % cp "%" "$font_dir/"
	cd ..
}

function install_bash_it {
	mkdir -p home_copy/.cache/the_dark_side/
	git clone --depth=1 https://github.com/Bash-it/bash-it.git home_copy/.cache/the_dark_side/bash_it
	HOME="$(realpath home_copy)" bash home_copy/.cache/the_dark_side/bash_it/install.sh --silent --no-modify-config
}

function install_theme {
	install_arc_theme
	install_powerline_fonts
	install_bash_it
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

function install_hacked_green {
	mkdir hacked_green && cd hacked_green || exit
	wget -c -O Hacked-Green.tgz "https://www.dropbox.com/s/jzinbd7o5fnkzhi/Hacked-Green.tgz?dl=0#"
	mkdir -p ../home_copy/.icons/
	tar -xf Hacked-Green.tgz
	mv Hacked-Green ../home_copy/.icons/
	cd ..
}

function install_cursor_theme {
	install_hacked_green
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

function install_dconf {
	mkdir dconf
	cd dconf || exit
	wget -c -O dconf.deb "http://ftp.fr.debian.org/debian/pool/main/d/d-conf/dconf-cli_0.22.0-1_amd64.deb"
	ar x dconf.deb data.tar.xz
	tar xf data.tar.xz
	mkdir -p ../home_copy/.cache/the_dark_side/
	mv usr/bin/dconf ../home_copy/.cache/the_dark_side/
	chmod u+x ../home_copy/.cache/the_dark_side/dconf
	cd ..
}

function install_terminix {
	wget -c -O Terminix.AppImage "https://bintray.com/probono/AppImages/download_file?file_path=Terminix-1.30-x86_64.AppImage"
	mv Terminix.AppImage home_copy/.cache/the_dark_side/
	cp ../terminix.bash home_copy/.cache/the_dark_side/
	chmod u+x home_copy/.cache/the_dark_side/{Terminix.AppImage,terminix.bash}
	mkdir -p home_copy/.local/share/applications home_copy/.local/share/xfce4/helpers
	cp ../com.gexperts.Terminix.desktop home_copy/.local/share/applications/
	cp ../custom-TerminalEmulator.desktop home_copy/.local/share/xfce4/helpers/
	mkdir -p home_copy/.local/share/appimagekit
	touch home_copy/.local/share/appimagekit/no_desktopintegration
}

function install_tmux {
	mkdir tmux
	cd tmux || exit
	wget -c -O tmux.deb "http://ftp.fr.debian.org/debian/pool/main/t/tmux/tmux_2.3-4~bpo8+1_amd64.deb"
	ar x tmux.deb data.tar.xz
	tar xf data.tar.xz
	mkdir -p ../home_copy/.cache/the_dark_side/
	mv usr/bin/tmux ../home_copy/.cache/the_dark_side/
	chmod u+x ../home_copy/.cache/the_dark_side/tmux
	cd ..
}

function install_software {
	install_atom
	install_atom_packages
	install_shellcheck
	install_dconf
	install_terminix
	install_tmux
}

cp ../bashrc home_copy/.bashrc

install_theme
install_icon_theme
install_cursor_theme
install_software

mkdir -p home_copy/.config/autostart
cp ../the_dark_side_check_version.desktop ../the_dark_side_update.desktop home_copy/.config/autostart/

cp ../main.bash ../check_version.bash ../update.bash ../the_dark_side.bash ../wallpaper_cli.png home_copy/.cache/the_dark_side/
tar -cJf home_package.tar.xz -C home_copy .
mv home_package.tar.xz ../
