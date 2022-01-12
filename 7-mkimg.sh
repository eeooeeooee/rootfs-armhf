#!/bin/bash

if [ -f ubuntu-20-04.img ]; then
	rm ubuntu-20-04.img
fi
dd if=/dev/zero of=ubuntu-20-04.img bs=1M count=1280
mkfs.ext4 ubuntu-20-04.img
if [ -d tmpfs ]; then
	:
else
	mkdir tmpfs
fi
mount ubuntu-20-04.img tmpfs
cp -rfp rootfs/* tmpfs/
sync
sleep 2
umount tmpfs/
sleep 2
rm -r tmpfs
e2fsck -p -f ubuntu-20-04.img
resize2fs -M ubuntu-20-04.img

