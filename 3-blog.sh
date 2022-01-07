#!/bin/bash
cp 1.1-17.10.30-release.tar.gz rootfs/var/www/html/
cd rootfs/var/www/html/
tar -zxvf 1.1-17.10.30-release.tar.gz
mv build blog
chmod 777 -R blog
rm 1.1-17.10.30-release.tar.gz
mv index.nginx-debian.html index.html
mkdir files
cd files
ln -s /home/ubuntu home
#ln -s /mnt/sda1/share share

