#!/bin/bash

# execute a series of commands to keep laptops in good working order.
# I have broken these commands down into types to make it easier to find them.

# Any sort of setup stuff

# Skel Desktop Location
if [ ! -h "/etc/skel/Desktop" ];then
	cd /etc/skel
	rm -rf Desktop
	ln -s /usr/local/src/CCHS-Config/skel/Desktop
fi

# Apt updates.  Don't need to be noisy.
echo "Updating package list";
apt-get -qq update;
echo "Package list updated";

# Specific Packages and PPA

# SSH Daemon
if ! which sshd &> /dev/null;then
	apt-get -y install openssh-server;
fi

# A real god damn vim
if [ -e "/usr/bin/vim.tiny" ];then
	apt-get -y remove vim-tiny;
	apt-get -y install vim;
fi


# Custom installs.
# Make sure to add appropriate files into the skel section for desktop icons

# Slic3r 0.9.2
# I looked but couldn't find a ppa for this
if [ ! -d "/usr/local/slic3r/0.9.2" ];then
	# slic3r 0.9.2 doesn't exist, install it.
	# This is a pre-packaged slic3r that should just work
	cd /usr/local/src
	wget http://dl.slic3r.org/linux/slic3r-linux-x86-0-9-2.tar.gz
	tar -zxf slic3r-linux-x86-0-9-2.tar.gz
	mv Slic3r /usr/local/slic3r/0.9.2

fi


# config resync
# Don't blow away everything, easier to just do it in parts
# may change this policy in the future

# Desktop
echo "Clearing Desktop";
rm -rf /home/test/Desktop
cp -R /etc/skel/Desktop /home/test
chown -R test:test /home/test/Desktop

# Config
# this doesn't need cleaning, but the defaults need to be recopied
cp -R /usr/local/src/CCHS-Config/Configs /home/test/

# Clean Downloads
rm -rf /home/test/Downloads/*
