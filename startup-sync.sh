#!/bin/bash

# This script connects/syncs to a git repository and runs a second script, sync-config.sh
# This script doesn't need internet to run.  We still want it to restore default configs from the local repo.

# do we have git?
if ! which git &> /dev/null;then
	echo "git not found.  Installing from repos";
	apt-get update;
	apt-get install git;
fi

# Do we have a local repo?
if [ -d "/usr/local/src/CCHS-Config" ]; then
	# sync local repo.
	echo "Directory exists.";
	cd /usr/local/src/CCHS-Config
	# double check options to force a pull.
	git pull origin
else
	# this is highly unusual, but may happen
	echo "No original clone.";
	# this git location may need to be updated at some point.
	git clone https://github.com/mage0r/CCHS-Config.git /usr/local/src/CCHS-Config
fi



# run sync-config.sh
