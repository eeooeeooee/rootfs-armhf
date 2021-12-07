#!/bin/bash
cat << EOF | chroot rootfs
update-rc.d mystart.sh defaults 90
systemctl enable ttyd
EOF

