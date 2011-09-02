#!/bin/sh

cd ~
if test -d ~/github/dotvim; then
	git clone git://github.com/manic/dotvim.git ~/github/dotvim/
else
	cd ~/github/dotvim
	git pull
	cd ~
fi

ln -sfn ~/github/dotvim .vim
ln -sfn ~/github/dotvim/vimrc .vimrc
