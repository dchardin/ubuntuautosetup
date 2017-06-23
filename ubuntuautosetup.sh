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

nodejs()
{

apt-get install nodejs
apt-get install npm
sudo ln -s /usr/bin/nodejs /usr/bin/node


npm -g install bower
npm -g install yarn
npm -g install webpack
npm -g install less
npm -g install grunt
npm -g install cordova
npm -g install generator
npm -g install express-generator 

}

ruby()
{

apt-get install ruby

gem install sass

}

php()
{
add-apt-repository ppa:ondrej/php
apt-get update
apt-get install php7.0 php5.6 php5.6-mysql php-gettext php5.6-mbstring php-mbstring php7.0-mbstring php-xdebug libapache2-mod-php5.6 libapache2-mod-php7.0

#switch from php7 to php5

a2dismod php7.0
a2enmod php5.6
service apache2 restart
update-alternatives --set php /usr/bin/php5.6

#switch from php5 to php7

#a2dismod php5.6 
#a2enmod php7.0
#service apache2 restart
#update-alternatives --set php /usr/bin/php5.6
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

