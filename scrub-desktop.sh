#!/bin/bash

# execute a series of commands to keep laptops in good working order.
# I have broken these commands down into types to make it easier to find them.

# this script just cleans the hacker user desktop

# config resync
# Don't blow away everything, easier to just do it in parts
# may change this policy in the future

# Desktop
echo -ne "Clearing Desktop";
rm -rf /home/hacker/Desktop
cp -RL /etc/skel/Desktop /home/hacker
chown -R hacker:hacker /home/hacker/Desktop
echo "...done.";

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
elif [[ "$LOWER_HOSTNAME" == *006* && "$LOWER_HOSTNAME" == *cchs* ]];then
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


ln -s /home/hacker/Configs/$PRINTER_CONFIG/slic3r-0.9.9/ /home/hacker/.Slic3r
echo "...done";

# Clean Downloads
# decide on this later
# rm -rf /home/hacker/Downloads/*
