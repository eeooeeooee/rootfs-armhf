#!/bin/bash
cp default rootfs/etc/nginx/sites-available/default
tar -zxvf h5ai.tar.gz -C rootfs/var/www/html/files/
cat <<EOT >> rootfs/etc/fstab
/dev/mmcblk0p6 / ext4 defaults,noatime,errors=remount-ro 0 1
EOT
cat <<EOT > rootfs/var/www/html/files/info.php
<?php
phpinfo();
?>
EOT
cat <<EOT > rootfs/etc/systemd/system/ttyd.service
[Unit]
Description=TTYD
After=syslog.target
After=network.target

[Service]
ExecStart=/usr/bin/ttyd login
Type=simple
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOT
cp ttyd.armhf rootfs/usr/bin/ttyd
chmod +x rootfs/usr/bin/ttyd
chmod +x rootfs/etc/systemd/system/ttyd.service
#cat <<EOT > rootfs/etc/network/interfaces.d/eth0
#auto eth0
#iface eth0 inet dhcp
#EOT
echo "now ,dont forget chroot and adduser ubuntu & passwd root"
echo "update-rc.d mystart.sh defaults 90"
echo "systemctl enable ttyd"
