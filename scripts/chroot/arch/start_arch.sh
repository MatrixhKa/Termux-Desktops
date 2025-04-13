#!/bin/sh

#Path of Archlinux rootfs
ARCHPATH="/data/local/tmp/chrootArch"

# Fix setuid issue
busybox mount -o remount,dev,suid /data

mount -o bind /dev $ARCHPATH/dev/
busybox mount -t proc proc $ARCHPATH/proc/
busybox mount -t sysfs sysfs $ARCHPATH/sys/
busybox mount -t devpts devpts $ARCHPATH/dev/pts/
busybox mount -o bind /sdcard $ARCHPATH/media/sdcard
busybox mount -t tmpfs /cache $ARCHPATH/var/cache

# /dev/shm for Electron apps
mkdir $ARCHPATH/dev/shm
busybox mount -t tmpfs -o size=256M tmpfs $ARCHPATH/dev/shm

# Mount sdcard
mkdir $ARCHPATH/sdcard
busybox mount --bind /sdcard $ARCHPATH/sdcard

# chroot into DEBIAN
#busybox chroot $ARCHPATH /bin/su - root
busybox chroot $ARCHPATH /bin/su - matrixz -c 'export DISPLAY=:0 && export PULSE_SERVER=127.0.0.1 && dbus-launch --exit-with-session && TU_DEBUG=noconform ZINK_DESCRIPTORS=lazy ZINK_DEBUG=compact openbox-session'
