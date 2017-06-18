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
umake nodejs
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

embedded_terminal_setup()
{

apt-get install xfonts-terminus

mkdir /home/donnie/.devilspie/
touch /home/donnie/.devilspie/DesktopConsole.ds
chown donnie /home/donnie/.devilspie/DesktopConsole.ds
cat << EOF > /home/donnie/.devilspie/DesktopConsole.ds
(if
        (matches (window_name) "DesktopConsole")
        (begin
                (unpin)
                (below)
    	(undecorate)
                (skip_pager)
                (center)
                (skip_tasklist)
		(geometry "+112+140")
                (wintype "utility")
        )
)
EOF


mkdir /home/donnie/.config/roxterm.sourceforge.net
touch /home/donnie/.config/roxterm.sourceforge.net/Global
chown donnie /home/donnie/.config/roxterm.sourceforge.net/Global

cat << EOF > /home/donnie/.config/roxterm.sourceforge.net/Global
[roxterm options]
warn_close=3
only_warn_running=1
profile=DesktopConsole
encoding=UTF-8
prefer_dark_theme=1
EOF

#need to insert logic to check if directory already exists

mkdir /home/donnie/.config/roxterm.sourceforge.net/Profiles
touch /home/donnie/.config/roxterm.sourceforge.net/Profiles/DesktopConsole
chown donnie /home/donnie/.config/roxterm.sourceforge.net/Profiles/DesktopConsole

cat << EOF > /home/donnie/.config/roxterm.sourceforge.net/Profiles/DesktopConsole
[roxterm profile]
font=Terminus 10
always_show_tabs=0
hide_menubar=1
show_add_tab_btn=0
saturation=0.000000
win_title=DesktopConsole
audible_bell=0
bell_highlights_tab=0
exit_action=1
scrollbar_pos=0
disable_menu_access=1
disable_menu_shortcuts=1
disable_tab_menu_shortcuts=1
show_tab_num=0
tab_close_btn=0
tab_pos=4
colour_scheme=GTK
width=100
height=30
EOF

#Need to add in logic to check if directory already exists

mkdir /home/donnie/.config/autostart/
cd /home/donnie/.config/autostart/
touch /home/donnie/.config/autostart/devil.desktop
chown donnie /home/donnie/.config/autostart/devil.desktop
cat << EOF > /home/donnie/.config/autostart/devil.desktop
[Desktop Entry]
Name=devil
GenericName=devil
Comment=Start these up at login
Exec=/home/donnie/.config/autostart/devil.sh
Terminal=False
Type=Application
X-GNOME-Autostart-enabled=true
EOF

touch /home/donnie/.config/autostart/devil.sh
chown donnie /home/donnie/.config/autostart/devil.sh
chmod 2777 /home/donnie/.config/autostart/devil.sh
cat << EOF > /home/donnie/.config/autostart/devil.sh
#!/bin/bash
devilspie & roxterm --profile=DesktopConsole --hide-menubar --title=DesktopConsole --role=borderless
EOF


touch /home/donnie/.config/autostart/clearsessions.sh
chown donnie /home/donnie/.config/autostart/clearsessions.sh
chmod 2777 /home/donnie/.config/autostart/clearsessions.sh
cat << EOF > /home/donnie/.config/autostart/clearsessions.sh
#!/bin/bash
rm -rf /home/*/.cache/sessions/*
EOF

}

main()
{
	make_resources_folder
	update_system
	install_chrome
	install_oraclejdk
	install_opera_developer
	install_simplescreenrecorder
	install_ubuntu_make
	apt_get_install_apps
	embedded_terminal_setup
	
}

main

