#!/bin/bash
cp tr-web-control.tar.gz rootfs/usr/share/transmission/web/
sed -i -e 's/127.0.0.1/*/g' rootfs/etc/transmission-daemon/settings.json
cd rootfs/usr/share/transmission/web/
mv index.html index.original.html
tar -zxvf tr-web-control.tar.gz -C ./
rm tr-web-control.tar.gz

