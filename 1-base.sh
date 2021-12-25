#!/bin/bash
if [ -f ubuntu-base-20.04.3-base-armhf.tar.gz ]; then
	:
else
	wget http://cdimage.ubuntu.com/ubuntu-base/releases/20.04.3/release/ubuntu-base-20.04.3-base-armhf.tar.gz
fi
if [ -d rootfs ]; then
	:
else
	mkdir rootfs
fi
if [ -f ttyd.armhf ]; then
	:
else
	wget https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.armhf
fi
if [ -f AriaNg-1.2.3.zip ]; then
	:
else
	wget https://github.com/mayswind/AriaNg/releases/download/1.2.3/AriaNg-1.2.3.zip
fi
tar -zxvf ubuntu-base-20.04.3-base-armhf.tar.gz -C rootfs
echo "nameserver 114.114.114.114" >> rootfs/etc/resolv.conf
cp /etc/apt/sources.list rootfs/etc/apt/sources.list
cat <<EOT > rootfs/etc/init.d/mystart.sh
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
if [ ! -f "/etc/ecoo" ]; then
resize2fs /dev/mmcblk0p6
fi
echo "Find /dev/sda1......."
if [ -b /dev/sda1 ]; then
       echo "the /dev/sda1 is exist"
       echo "mounting /dev/sda1 to /mnt/sda1"
       if [ ! -d "/mnt/sda1" ]; then
       mkdir -p /mnt/sda1
       fi
       mount /dev/sda1 /mnt/sda1
else
       echo "the /dev/sda1 isn't exist"
fi
echo "Find /dev/mmcblk1......."
if [ -b /dev/mmcblk1p1 ]; then
       echo "the /dev/mmcblk1p1 is exist"
       echo "mounting /dev/mmcblk1p1 to /mnt/mmc1"
       if [ ! -d "/mnt/mmc1" ]; then
       mkdir -p /mnt/mmc1
       fi
       mount /dev/mmcblk1p1 /mnt/mmc1
else
       echo "the /dev/mmcblk1p1 isn't exist"
fi
if [ ! -f "/etc/ecoo" ]; then
echo "resize2fs /dev/mmcblk0p6" > /etc/ecoo
fi
/usr/bin/vlmcsd

EOT
chmod +x rootfs/etc/init.d/mystart.sh


