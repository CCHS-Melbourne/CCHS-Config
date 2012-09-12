#!/bin/bash

# execute a series of commands to keep laptops in good working order.
# I have broken these commands down into types to make it easier to find them.

# Apt updates.

apt-get update;


# Specific Packages and PPA

# SSH Daemon
if ! which sshd &> /dev/null;then
	apt-get install openssh-server;
fi

# A real god damn vim
if dpkg -l|grep vim-tiny &> /dev/null;then
	apt-get remove vim-tiny;
	apt-get install vim;
fi


# Custom installs.

# Slic3r 0.9.2
# I looked but couldn't find a ppa for this
if [ ! -d "/usr/local/slic3r/0.9.2" ];then
	# slic3r 0.9.2 doesn't exist, install it.
	# This is a pre-packaged slic3r that should just work
	cd /usr/local/src
	wget http://dl.slic3r.org/linux/slic3r-linux-x86-0-9-2.tar.gz
	tar -zxf slic3r-linux-x86-0.9.2.tar.gz
	mv Slic3r slic3r-linux-x86-0.9.2

fi


# config resync
# Don't blow away everything, easier to just do it in parts
# may change this policy in the future

# Desktop

# Config
# this doesn't need cleaning, but the defaults need to be recopied
cp -R /usr/local/src/CCHS-Config/Configs /home/test/

# Clean Downloads
rm -rf /home/test/Downloads/*
