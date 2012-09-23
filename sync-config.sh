#!/bin/bash

# execute a series of commands to keep laptops in good working order.
# I have broken these commands down into types to make it easier to find them.

# Any sort of setup stuff

# make sure we have a hacker user and create it if required.
echo -ne "Checking Hacker User exists";
if ! id -un hacker &> /dev/null;then
	useradd -mU hacker -s /bin/bash
	echo hacker:hacker | chpasswd
	echo -ne "...created User"
fi

# check hacker groups
# id -Gn produces a set of groups
required_groups=( "hacker" "adm" "cdrom" "sudo" "dip" "plugdev" "lpadmin" "sambashare" )
hacker_groups=( $(id -Gn hacker) )
add_groups=()
for i in "${required_groups[@]}"; do
	skip=0
	for j in "${hacker_groups[@]}"; do
		if [ $i == $j  ]; then
			skip=1;
			break;
		fi
	done
	if [ $skip -eq "0" ]; then
		add_groups+=("$i");
	fi
done

for i in "${add_groups[@]}"; do
	adduser hacker $i;
	echo -ne "...added groups";
done

echo "...done.";

# wireless connection
echo -ne "Copying Network Connection";
if [ ! -h "/etc/NetworkManager/system-connections/CCHS" ];then
	cd /etc/NetworkManager/system-connections/
	cp /usr/local/src/CCHS-Config/system-connections/CCHS .
fi
echo "...done.";

# Skel Desktop Location
if [ ! -h "/etc/skel/Desktop" ];then
	echo -ne "Creating Desktop skel";
	cd /etc/skel
	rm -rf Desktop
	ln -s /usr/local/src/CCHS-Config/skel/Desktop
	echo "...done.";
fi

# Apt updates.  Don't need to be noisy.
echo -ne "Updating package list";
apt-get -qq update;
echo "...done.";
echo -ne "Updating packages";
apt-get -qqy upgrade;
echo "...done.";

# Specific Packages and PPA

# SSH Daemon
echo -ne "Checking sshd installed";
if ! which sshd &> /dev/null;then
	apt-get -qqy install openssh-server;
fi
echo "...done";

# A real god damn vim
echo -ne "Checking vim installed";
if [ -e "/usr/bin/vim.tiny" ];then
	apt-get -qqy remove vim-tiny;
	apt-get -qqy install vim;
fi
echo "...done";

# Arduino IDE from repos
echo -ne "Checking Arduino IDE installed";
if [ ! -e "/usr/bin/arduino" ]; then
	apt-get -qqy install arduino;
fi
echo "...done";

# Pronterface and Skeinforge
echo -ne "Checking Pronterface and Skeinforge installed";
if [ ! -e "/usr/bin/pronterface" ]; then
	apt-add-repository -qy ppa:richi-paraeasy/ppa
	apt-get -qq update
	apt-get -qqy install printrun-gui skeinforge
fi
echo "...done";

# LibreCAD
echo -ne "Checking LibreCAD installed";
if [ ! -e "/usr/bin/librecad" ]; then
	apt-get -y install librecad;

fi
echo "...done";

# OpenSCAD
echo -ne "Checking OpenSCAD installed";
if [ ! -e "/usr/bin/openscad" ]; then
	apt-add-repository -y ppa:chrysn/openscad
	apt-get -qq update
	apt-get -y install openscad
fi
echo "...done";



# Custom installs.
# Make sure to add appropriate files into the skel section for desktop icons

# Slic3r 0.9.2
# I looked but couldn't find a ppa for this
if [ ! -d "/usr/local/slic3r/0.9.2" ];then
	# slic3r 0.9.2 doesn't exist, install it.
	# This is a pre-packaged slic3r that should just work
	# Problems exist with ownership permissions.
	echo -ne "Installing Slic3r 0.9.2";
	cd /usr/local/src
	if [ ! -e "slic3r-linux-x86-0-9-2.tar.gz" ]; then
		wget http://dl.slic3r.org/linux/slic3r-linux-x86-0-9-2.tar.gz
	fi
	# this will only work as one user
	#tar --no-same-owner -zxf slic3r-linux-x86-0-9-2.tar.gz
	tar -zxf slic3r-linux-x86-0-9-2.tar.gz
	mkdir -p /usr/local/slic3r
	mv Slic3r /usr/local/slic3r/0.9.2
	echo "...done.";
fi

# Cura 12.08
if [ ! -d "/usr/local/cura/12.08" ];then
	echo -ne "Installing Cura 12.08";
	apt-get -y install python-opengl libssl0.9.8 python-numpy
	cd /usr/local/src
	if [ ! -e "linux-Cura-12.08.tar.gz" ];then
		wget https://github.com/downloads/daid/Cura/linux-Cura-12.08.tar.gz
	fi
	tar  --no-same-owner -zxf linux-Cura-12.08.tar.gz
	mkdir -p /usr/local/cura
	mv linux-Cura-12.08 /usr/local/cura/12.08
	# Cura needs to write to it's preferences file
	touch /usr/local/cura/12.08/Cura/preferences.ini
	chmod a+w /usr/local/cura/12.08/Cura/preferences.ini
	echo "...done.";
fi

# config resync
# Don't blow away everything, easier to just do it in parts
# may change this policy in the future

# Desktop
echo -ne "Clearing Desktop";
rm -rf /home/hacker/Desktop
cp -RL /etc/skel/Desktop /home/hacker
chown -R hacker:hacker /home/hacker/Desktop
echo "...done.";

# reset hacker to autologin
echo -ne "Setting hacker to be default login";
rm -rf /etc/lightdm
cp -RL /usr/local/src/CCHS-Config/lightdm /etc/
echo "...done";

# Config
# this doesn't need cleaning, but the defaults need to be recopied
# any new files will stay
echo -ne "Resetting Configs";
cp -R /usr/local/src/CCHS-Config/Configs /home/hacker/
chown -R hacker:hacker /home/hacker/Configs
echo "...done";

# Clean Downloads
# decide on this later
# rm -rf /home/hacker/Downloads/*
echo "Restarting LightDM";
service lightdm restart
