#!/bin/bash
cat << EOF | chroot rootfs
apt update
apt upgrade -y
echo "ecoo.top" > /etc/hostname
mknod /dev/console c 5 1
mknod /dev/ttyAMA0 c 204 64
mknod /dev/ttyAMA1 c 204 65
mknod /dev/ttyS000 c 204 64
mknod /dev/null    c 1   3
mknod /dev/urandom   c 1   9
mknod /dev/zero    c 1   5
mknod /dev/random    c 1   8
mknod /dev/tty    c 5   0
apt-get install -y usbutils network-manager nginx apt-utils \
locales wget curl vim iputils-ping bash-completion \
ssh net-tools sudo php-fpm php-cgi php-sqlite3 transmission-daemon \
cron ethtool zip ifupdown htop rsyslog dialog resolvconf 
sleep 2
sed -i -e 's/#PasswordAuthentication/PasswordAuthentication/g' /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "127.0.0.1 localhost" > /etc/hosts
echo "127.0.1.1 ecoo.top" >> /etc/hosts
echo "Asia/Shanghai" > /etc/timezone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "en_US.UTF-8 UTF-8" > etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> etc/locale.gen
echo "zh_CN.GB2312 GB2312" >> etc/locale.gen
echo "zh_CN.GBK GBK" >> etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
update-rc.d mystart.sh defaults 90
apt autoremove
apt-get autoclean
apt-get clean
apt autoclean
apt clean
EOF
