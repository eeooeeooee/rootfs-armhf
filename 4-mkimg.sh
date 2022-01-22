#!/bin/bash

OUTPUT="ubuntu-$(date +%Y%m%d).img"
echo "IMG will output into: $(pwd)/$OUTPUT"

[ -f "$OUTPUT" ] && rm -f $OUTPUT tmpfs
dd if=/dev/zero of=$OUTPUT count=0 obs=1 seek=1280M
mkfs.ext4 $OUTPUT
mkdir -p tmpfs
mount $OUTPUT tmpfs
cp -rfp rootfs/* tmpfs
sync
umount -l tmpfs
rm -rf tmpfs
e2fsck -p -f $OUTPUT
resize2fs -M $OUTPUT
