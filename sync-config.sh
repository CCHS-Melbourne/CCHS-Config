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
echo "...done";

echo -ne "Checking Hacker User is 1000";
# Slic3r Needs to run as uid 1000
hacker_uid=`id -u hacker`
hacker_gid=`id -g hacker`
if [ "$hacker_uid" -ne "1000" ]; then
	echo -ne "...hacker user is not uid 1000";
	sed -ie 's/:1000:1000:/:'$hacker_uid':'$hacker_gid':/g' "/etc/passwd"
	sed -ie 's/hacker:x:'$hacker_uid':'$hacker_gid':/hacker:x:1000:1000:/g' "/etc/passwd"

	# resetting home directories
	# only bother with the hacker user
	# re-evaluate this later
	
	chown -R hacker:hacker /home/hacker
fi
echo "...done";

# check hacker groups
# id -Gn produces a set of groups
required_groups=( "hacker" "adm" "cdrom" "sudo" "dip" "plugdev" "lpadmin" "sambashare" "dialout" )
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


# is the startup script run by lightdm's upstart script?
echo -ne "Checking lightdm startup script";
if [ `grep 'startup-sync.sh' /etc/init/lightdm.conf|wc -l` -eq 0 ]; then
	# file is stock
	cp /usr/local/src/CCHS-Config/init/lightdm.conf /etc/init/lightdm.conf
	echo -ne "...adding";
fi
echo "...done.";

# wireless connection
echo -ne "Copying Network Connection";
if [ ! -h "/etc/NetworkManager/system-connections/CCHS" ];then
	cd /etc/NetworkManager/system-connections/
	cp /usr/local/src/CCHS-Config/system-connections/CCHS .
	# replace with the system mac address
	# get the mac address
	MAC_ADDRESS=`ifconfig | grep wlan | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'`
	sed -ie 's/<MAC>/'$MAC_ADDRESS'/g' "/etc/NetworkManager/system-connections/CCHS"
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
	echo -ne "...vim-tiny removed";
fi
if [ ! -e "/usr/bin/vim" ];then
	apt-get -qqy install vim;
	echo -ne "...vim installed";
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
	apt-add-repository -y ppa:richi-paraeasy/ppa
	apt-get -qq update
	apt-get -qqy install printrun-gui skeinforge
fi
echo "...done";

# LibreCAD
echo -ne "Checking LibreCAD installed";
if [ ! -e "/usr/bin/librecad" ]; then
	apt-get -qy install librecad;

fi
echo "...done";

# OpenSCAD
echo -ne "Checking OpenSCAD installed";
if [ ! -e "/usr/bin/openscad" ]; then
	apt-add-repository -y ppa:chrysn/openscad
	apt-get -qq update
	apt-get -qy install openscad
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
		wget http://dl.slic3r.org/linux/old/slic3r-linux-x86-0-9-2.tar.gz
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

# setup flags to load specific configs

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
rm -rf /home/hacker/.Slic3r

#which machine are we?
LOWER_HOSTNAME=`echo $HOSTNAME | tr [:upper:] [:lower:]`
if [[ "$LOWER_HOSTNAME" == *004* && "$LOWER_HOSTNAME" == *cchs* ]];then
	# This is the frankencake
	echo -ne "...default Slic3r profile is FrankenCake";
	PRINTER_CONFIG="FrankenCake";
elif [[ "$LOWER_HOSTNAME" == *011* && "$LOWER_HOSTNAME" == *cchs* ]];then
	# this is the prusa
	echo -ne "...default Slic3r profile is Prusa";
	PRINTER_CONFIG="Prusa";
else
	# this is the default
	echo -ne "...default Slic3r profile is Prusa";
	PRINTER_CONFIG="Prusa";
fi


ln -s /home/hacker/Configs/$PRINTER_CONFIG/slic3r-0.9.2/ /home/hacker/.Slic3r
echo "...done";

# Clean Downloads
# decide on this later
# rm -rf /home/hacker/Downloads/*
