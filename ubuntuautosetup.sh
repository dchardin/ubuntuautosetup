#!/bin/bash

make_resources_folder()
{
mkdir /AutoInstallResources
cd /AutoInstallResources
}

update_system()
{
	apt-get -y update
	if [ $? -ne 0 ]
		echo "There was a problem updating. exiting "
		exit $?
	fi
	apt-get -y upgrade
	if [ $? -ne 0 ]
        	echo "There was a problem updating. exiting "
        	exit $?
	fi
	apt-get -y dist-upgrade
	if [ $? -ne 0 ]
        	echo "There was a problem updating. exiting "
        	exit $?
	fi
}

#-------------------------------------------------------------------------------
# manual setup notes
#-------------------------------------------------------------------------------
# Open Chrome, Sign in, ensure sync works well

install_chrome()
{
	apt-get -y  install wget
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
	apt-get -y install -f 
}

apt_get_install_apps()
{
	app_packages=( \
		"atop" \
		"autokey-gtk" \
		"automake" \
		"binutils" \
		"byzanz" \
		"bzip2-devel" \
		"cmake" \
		"curl" \
		"curl-devel" \
		"devilspie" \
		"dkms" \
		"dos2unix" \
		"evince" \
		"expat-devel" \
		"expect" \
		"gcc" \
		"gcc-c++" \
		"git" \
		"glibc-devel" \
		"glibc-headers" \
		"gnupg" \
		"golang" \
		"google-chrome-stable" \
		"gstreamer" \
		"gstreamer-ffmpeg" \
		"gstreamer-plugins-bad" \
		"gstreamer-plugins-bad-free" \
		"gstreamer-plugins-bad-free-extras" \
		"gstreamer-plugins-bad-nonfree" \
		"gstreamer-plugins-base" \
		"gstreamer-plugins-good" \
		"gstreamer-plugins-ugly" \
		"htop" \
		"hexchat" \
		"insync" \
		"k3b-extras-freeworld" \
		"kernel-devel" \
		"kernel-headers" \
		"libdvbpsi" \
		"libdvdcss" \
		"libdvdnav" \
		"libdvdread" \
		"libgomp" \
		"lsdvd" \
		"m4" \
		"make" \
		"mercurial" \
		"ncurses-devel" \
		"nmap" \
		"openssh" \
		"openvpn" \
		"patch" \
		"python-argparse" \
		"python-devel" \
		"python-urllib2_kerberos" \
		"pytz" \
		"ruby" \
		"rxvt" \
		"screen" \
		"screenfetch" \
		"sound-juicer" \
		"steam" \
		"terminator" \
		"texinfo" \
		"tmux" \
		"unzip" \
		"vim" \
		"vlc" \
		"xfreerdp" \
		"xine-lib" \
		"xine-lib-extras" \
		"xine-lib-extras-freeworld" \
		"zlib-devel" \
		"unzip" \
		"dvdstyler" \
		"devede" \
		"simplescreenrecorder" \
		"qt5-qtbase" \
		"qt5-qtbase-devel" \
		"qt5-qtdeclarative" \
		"qt5-qtdeclarative-devel" \
		"qt5-qtgraphicaleffects" \
		"qt5-qtquickcontrols" \
		"redhat-rpm-config" \
		"flash-plugin" \
		"nspluginwrapper" \
		"alsa-plugins-pulseaudio" \
		"libcurl" \
		"gpick" \
	)


	for i in "${app_packages[@]}"
	do
		echo "Installing: " $i
		apt-get -y install $i >>~/postinstall_log.txt 2>>~/postinstall_errors.txt
		if [ $? -ne 0 ]; then
			echo "There was a problem installing " $i " see log file "
		fi
	done
}

main()
{
	make_resources_folder
	update_system
	install_chrome
	apt_get_install_apps
}

main

