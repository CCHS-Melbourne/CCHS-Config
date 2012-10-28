#!/bin/bash

apt-get install git dpkg-dev
cd /usr/local/src/
mkdir linuxcnc-git

cd linuxcnc-git
git clone git://git.linuxcnc.org/git/linuxcnc.git .

cd debian
./configure sim

#stupid dependencies
apt-get install -qy texlive-lang-french texlive-lang-german texlive-lang-spanish texlive-lang-polish libmodbus-dev libpth-dev dvipng tcl-dev tk-dev tcl8.4-dev tk8.4-dev bwidget libxaw7-dev libncurses-dev libreadline-dev asciidoc source-highlight dblatex groff python-dev python-tk python-lxml libglu1-mesa-dev libgl1-mesa-swx11-dev libgtk2.0-dev libgnomeprintui2.2-dev autoconf libboost-python-dev texlive-lang-cyrillic python-gnome2-dev glade-gtk2

 cd ..
dpkg-checkbuilddeps

apt-get purge tcl8.4-dev tk8.4-dev

cd src
./autogen.sh
./configure --enable-simulator --prefix=/usr/local/linuxcnc
make
make install
