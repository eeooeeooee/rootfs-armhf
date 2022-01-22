#!/bin/bash

mkdir -p downloads && cd downloads
{
	if [ ! -f 1.1-17.10.30-release.tar.gz ]
	then
		wget --no-check-certificate http://typecho.org/downloads/1.1-17.10.30-release.tar.gz
	fi
} &
{
	if [ ! -f ttyd.armhf ]
	then
		wget --no-check-certificate https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.armhf
	fi
} &
{
	if [ ! -f AriaNg-1.2.3.zip ]
	then
		wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.2.3/AriaNg-1.2.3.zip
	fi
} &
wait
cd -

# blog
mkdir -p rootfs/var/www/html/files rootfs/etc/nginx/sites-available
tar -zxvf downloads/1.1-17.10.30-release.tar.gz -C rootfs/var/www/html > /dev/null 2>&1
cd rootfs/var/www/html
mv build blog
chmod 777 -R blog
mv index.nginx-debian.html index.html
ln -s /home/ubuntu ./files/home
cd -
cp pre_files/wiki/nginx_default rootfs/etc/nginx/sites-available/default
cp pre_files/wiki/index.html rootfs/var/www/html
cp pre_files/wiki/{kms.html,teasiu-wx.jpg} rootfs/var/www/html/files

cp pre_files/h5ai/{_h5ai.footer.md,_h5ai.header.html} rootfs/var/www/html/files
cp pre_files/h5ai/_h5ai.footer2.md rootfs/home/ubuntu/_h5ai.footer.md
tar -zxvf pre_files/h5ai/h5ai.tar.gz -C rootfs/var/www/html/files > /dev/null 2>&1

cat <<EOT > rootfs/var/www/html/files/info.php
<?php
phpinfo();
?>
EOT

# transmission
mkdir -p rootfs/usr/share/transmission/web rootfs/etc/transmission-daemon
mv -f rootfs/usr/share/transmission/web/index.html rootfs/usr/share/transmission/web/index.original.html
tar -zxvf pre_files/transmission/tr-web-control.tar.gz -C rootfs/usr/share/transmission/web > /dev/null 2>&1
cp -a pre_files/transmission/tr-settings.json rootfs/etc/transmission-daemon/settings.json

# ttyd
cp -a pre_files/ttyd.service rootfs/etc/systemd/system
chmod 644 rootfs/etc/systemd/system/ttyd.service
cp -a downloads/ttyd.armhf rootfs/usr/bin/ttyd
chmod +x rootfs/usr/bin/ttyd

# vlmcsd
cp -a pre_files/vlmcsd rootfs/usr/bin/vlmcsd
chmod +x rootfs/usr/bin/vlmcsd

# frpc
mkdir -p rootfs/etc/frp
cp pre_files/frpc/frpc rootfs/usr/bin
chmod +x rootfs/usr/bin/frpc
cp pre_files/frpc/frpc.ini rootfs/etc/frp
cp pre_files/frpc/frpc.service rootfs/etc/systemd/system
chmod 644 rootfs/etc/systemd/system/frpc.service

# aria2
mkdir -p rootfs/home/ubuntu/downloads rootfs/var/www/html/ariang rootfs/usr/local/aria2
unzip -o -q downloads/AriaNg-1.2.3.zip -d rootfs/var/www/html/ariang
touch rootfs/usr/local/aria2/aria2.session
chmod 777 rootfs/usr/local/aria2/aria2.session
cp -a pre_files/aria2.conf rootfs/usr/local/aria2
cp -a pre_files/aria2c.service rootfs/etc/systemd/system
chmod 644 rootfs/etc/systemd/system/aria2c.service

# others
cp -a pre_files/client-mode rootfs/home/ubuntu/
cp -a pre_files/bootargs4.bin rootfs/usr/bin/
cp -a pre_files/boot4.sh rootfs/usr/bin/recoverbackup
chmod +x rootfs/usr/bin/recoverbackup
cp -a pre_files/{docker_image_update,automount,coremark} rootfs/sbin
chmod +x rootfs/sbin/{docker_image_update,automount,coremark}
cp -a pre_files/99-helloworld.sh rootfs/etc/profile.d

# end
cat << EOF | chroot rootfs
systemctl enable ttyd
systemctl enable aria2c.service
EOF
