#!/bin/bash

# This script will chroot a full system into the specified directory

# Determine directory
target=$1
if [ -d "${target}" ]; then
  mount -t proc none "${target}/proc"
  mount -obind /dev "${target}/dev"
  mount -obind /sys "${target}/sys"
  echo "Then run: chroot ${target} /bin/bash "
else
  echo "Usage: chroot_mount_system <dir>"
fi

