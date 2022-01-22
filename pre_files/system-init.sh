#!/bin/bash

### BEGIN INIT INFO
# Provides:          slitaz.cn
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6                                   
# Short-Description: self define auto start
# Description:       self define auto start
### END INIT INFO

if [ ! -f /etc/first_init ]
then
	resize2fs /dev/mmcblk0p6
fi
if [ ! -f /etc/first_init ]
then
	echo "resize2fs /dev/mmcblk0p6" > /etc/first_init
fi
if [ ! -f /swapfile ]
then
{
	dd if=/dev/zero of=/swapfile bs=1M count=800
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
} &
fi
grep -q '/swapfile' /etc/fstab || echo "/swapfile swap swap defaults,nofail 0 0" >> /etc/fstab
echo "/sbin/automount" > /sys/kernel/uevent_helper
/sbin/automount
/usr/bin/vlmcsd
