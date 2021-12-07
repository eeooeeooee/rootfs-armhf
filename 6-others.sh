#!/bin/bash
cat << EOF | chroot rootfs
update-rc.d mystart.sh defaults 90
systemctl enable ttyd
EOF
cp -rf client-mode rootfs/home/ubuntu/
cp boot4.sh bootargs4.bin rootfs/home/ubuntu/

