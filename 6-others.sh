#!/bin/bash
if [ -f AriaNg-1.2.3.zip ]; then
	:
else
	wget https://github.com/mayswind/AriaNg/releases/download/1.2.3/AriaNg-1.2.3.zip
fi
mkdir -p rootfs/home/ubuntu/downloads
mkdir -p rootfs/var/www/html/ariang
unzip AriaNg-1.2.3.zip -d rootfs/var/www/html/ariang
mkdir -p rootfs/usr/local/aria2
touch rootfs/usr/local/aria2/aria2.session
chmod 777 rootfs/usr/local/aria2/aria2.session
cat << EOT > rootfs/usr/local/aria2/aria2.conf
dir=/home/ubuntu/downloads
disable-ipv6=true
enable-rpc=true
rpc-allow-origin-all=true
rpc-listen-all=true
#rpc-listen-port=6800
continue=true
input-file=/usr/local/aria2/aria2.session
save-session=/usr/local/aria2/aria2.session
max-concurrent-downloads=20
save-session-interval=120
connect-timeout=120
#lowest-speed-limit=10K
max-connection-per-server=10
#max-file-not-found=2
min-split-size=10M

split=10
check-certificate=false
#http-no-cache=true
EOT

cat << EOT > rootfs/etc/systemd/system/aria2c.service
[Unit]
Description=Aria2c

[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/aria2c --conf-path=/usr/local/aria2/aria2.conf
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
EOT

cat << EOF | chroot rootfs
update-rc.d mystart.sh defaults 90
systemctl enable ttyd
systemctl enable aria2c.service
EOF
cp -rf client-mode rootfs/home/ubuntu/
cp bootargs4.bin rootfs/usr/bin/
cp boot4.sh rootfs/usr/bin/recoverbackup
chmod +x rootfs/usr/bin/recoverbackup
cp wiki/_h5ai.footer2.md rootfs/home/ubuntu/_h5ai.footer.md

