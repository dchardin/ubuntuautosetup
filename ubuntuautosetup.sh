#!/bin/bash


#-------------------------------------------------------------------------------
# manual setup notes
#-------------------------------------------------------------------------------
# Open Chrome, Sign in, ensure sync works well
#
# adobe flash (for legacy sites)
# sudo vi /etc/sources.list
# uncomment the partner repo
# save and apt-get update
# sudo apt-get install adobe-flashplugin
#
# Manually install yed
# Manually install pencil
# Set up virtual machines
# Set up hexchat
# Manually install pinta
#
# Manually configure desktop to deactivate icons.
# Manually configure desktop to deactivate icons in menus
#


#-------------------------------------------------------------------------------
# Notes on netbeans setup 
#-------------------------------------------------------------------------------
#
# Activate components one by one
# Install Darcula theme




make_resources_folder()
{
mkdir /AutoInstallResources
cd /AutoInstallResources
}

update_system()
{
	apt-get -y update
	if [ $? -ne 0 ]; then
		echo "There was a problem updating. exiting "
		exit $?
	fi
	apt-get -y upgrade
	if [ $? -ne 0 ]; then
        	echo "There was a problem updating. exiting "
        	exit $?
	fi
	apt-get -y dist-upgrade
	if [ $? -ne 0 ]; then
        	echo "There was a problem updating. exiting "
        	exit $?
	fi
}


install_chrome()
{
	apt-get -y  install wget
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
	apt-get -y install -f 
}

install_oraclejdk()
{
	add-apt-repository ppa:webupd8team/java
	apt-get update
	apt-get install oracle-java8-installer

	echo "JAVA_HOME="/usr/lib/jvm/java-8-oracle"" >> /etc/environment
	source /etc/environment
}

install_opera_developer()
{
add-apt-repository 'deb https://deb.opera.com/opera-stable/ stable non-free'
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
apt-get update
apt-get install opera-developer
}

install_simplescreenrecorder()
{
add-apt-repository ppa:maarten-baert/simplescreenrecorder
apt-get update
apt-get install simplescreenrecorder
}

install_ubuntu_make()
{
add-apt-repository ppa:ubuntu-desktop/ubuntu-make
apt-get update
apt-get install ubuntu-make

umake swift
umake android
umake games stencyl
umake games superpowers
umake games twine
umake web firefox-dev
umake web visual-studio-code
umake ide atom
umake ide eclipse-cpp
umake ide clion
umake ide netbeans
umake ide lighttable
umake ide eclipse
umake ide pycharm
umake ide arduino
umake ide eclipse-jee
umake ide sublime-text
umake ide eclipse-php
}

npm_install()
{
npm install bower
npm install yarn
npm install webpack
}

apt_get_install_apps()
{
	app_packages=( \
		"atop" \
		"autokey-gtk" \
		"automake" \
		"binutils" \
		"byzanz" \
		"cargo" \
		"cowsay" \
		"cmake" \
		"curl" \
		"devilspie" \
		"dkms" \
		"dos2unix" \
		"evince" \
		"expect" \
		"fbreader" \
		"gimp" \
		"gimp-gap" \
		"git" \
		"gnupg" \
		"golang" \
		"htop" \
		"hexchat" \
		"lsdvd" \
		"m4" \
		"make" \
		"mercurial" \
		"nmap" \
		"openvpn" \
		"p7zip" \
		"pdfmod" \
		"patch" \
		"python" \
		"python2.7-devel" \
		"python-argparse" \
		"perl" \
		"pitivi" \
		"ruby" \
		"rxvt" \
		"screen" \
		"screenfetch" \
		"sound-juicer" \
		"sqlitebrowser" \
		"screenruler" \
		"terminator" \
		"texinfo" \
		"tmux" \
		"unzip" \
		"vim" \
		"vlc" \
		"unzip" \
		"devede" \
		"gpick" \
		"virtualbox" \
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
#	make_resources_folder
#	update_system
#	install_chrome
#	install_oraclejdk
#	install_opera_developer
#	install_simplescreenrecorder
#	install_ubuntu_make
#	apt_get_install_apps
	
}

main

