#!/bin/sh

# 用於設定新機器的Rails環境，主要是安裝要用到的套件
# 11.09.02	Det!C				v1.0

installer() {
	# ==Set alias==
	checkAlias_ll=$(grep "alias ll='ls -alF'" ~/.bashrc)

	if [ "$checkAlias_ll" = "" ]; then
		echo "alias ll='ls -alF'" >> ~/.bashrc
	fi

	# ==Install locales==
	cat /dev/null > /etc/default/locale
	cat > /etc/locale.gen <<EOF
en_US.UTF-8 UTF-8
en_US ISO-8859-1
zh_TW.UTF-8 UTF-8
zh_TW BIG5
EOF
	/usr/sbin/locale-gen

	# ==Basic setup==
	apt-get update
	apt-get upgrade -y
	apt-get install -y sudo make

	DEBIAN_FRONTEND=noninteractive apt-get install -y \
			bash \
			curl \
			dstat \
			iperf \
			less \
			lftp \
			mdadm \
			most \
			mtr-tiny \
			mysql-client \
			nmap \
			openssh-server \
			p7zip \
			rcconf \
			rsync \
			sharutils \
			sudo \
			sysstat \
			tcpdump \
			tcsh \
			telnet \
			vim-nox \
			w3m \
			wget \
			xfsdump \
			xfsprogs

	# ==library==
	apt-get install -y \
			libssl-dev \
			libexpat-dev \
			libmysqlclient-dev \
			libxml2-dev

	# ==程式語言類==
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
			bash-completion \
			build-essential \
			default-jdk \
			gawk \
			git \
			mercurial \
			perl \
			python \
			ruby
	DEBIAN_FRONTEND=noninteractive apt-get purge -y \
			exim4-config \
			exim4-base \
			nano
	apt-get clean

	# Configure Timezone
	cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime

	# ==Install the packages for Rails and Passenger==
	apt-get install -y vim git-core tig apache2 mysql-server libmysqlclient-dev libreadline5-dev
	apt-get install -y libcurl4-openssl-dev apache2-prefork-dev

	# ==Setup vim env and plugins==
	cd ~
	if test -d ~/github/dotvim; then
		echo "run git pull for dotvim\n"
		cd ~/github/dotvim
		git pull
		cd ~
	else
		echo "run git clone for dotvim\n"
		git clone git://github.com/manic/dotvim.git ~/github/dotvim/
	fi
	ln -sfn ~/github/dotvim .vim
	ln -sfn ~/github/dotvim/vimrc .vimrc

	# ==Notice==
	echo "接著你需要依照作業系統，下載Ruby Enterprise Edition並安裝，並做相對應設定\n"
	echo "[ Example ]\n"
	echo "	# wget http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_1.8.7-2011.03_amd64_debian6.0.deb\n"
	echo "	# dpkg -i ruby-enterprise_1.8.7-2011.03_amd64_debian6.0.deb\n"
	echo "	# echo 'export PATH="/usr/local/lib/ruby/gems/1.8/bin:$PATH"' >> ~/.profile && . ~/.profile\n"
	echo "\n完成後再設定Passenger，剩餘的部份請參考README.md\n"
	echo "	# /usr/local/bin/passenger-install-apache2-module\n"

}

echo "\nThis script file used for setup Rails environment."
read -p "Start the setup? (y/N): " userentry

if [ "$userentry" = "Y" ] || [ "$userentry" = "y" ] ; then
	echo "===Starting===\n"
	installer
else
	echo "Interrupt!"
fi
