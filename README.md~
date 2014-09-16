CCHS-Config
===========

Connected Community Hackerspace Melbourne's configuration files for laptops.

This repository is responsible for maintaining laptops at the Melbourne Hackerspace.

It's main files are both bash shell scripts.

startup-sync.sh should never change.  It connects to this git repository, downloads the newest sync-config.sh and executes it.

sync-config.sh runs a series of commands, for example but not limited too....install new packages from repositories, compile software and restore configuration files.

The configs directory contains configuration options for specific software and the directory structure should read as thus:
configs/slic3r/0.9.2/

Different machines will have appropriately named ini files, or a seperate directory if multiple files are required.  If there are machine specific defaults, for example slic3r on the two 3d printer machines, they should be specified in sync-config.sh at matched to hostname.

