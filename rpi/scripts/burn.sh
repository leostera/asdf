#!/bin/bash -e

readonly DISK_N=$(
  diskutil list \
    | grep 31 \
    | head -n 1 \
    | awk '{ print $5 }'
)
readonly DISK="/dev/${DISK_N}"
readonly VOLUME_NAME="ALPINE"
readonly VOLUME_PATH="/Volumes/${VOLUME_NAME}"
readonly FILE="alpine-${MARK}.tar.gz"
readonly SIZE=$(
  du -sk ${FILE} \
    | cut -f 1
)

echo "Cleaning up disk..."
diskutil mountDisk ${DISK}
diskutil eraseDisk fat32 ${VOLUME_NAME} MBR ${DISK}
echo "Copying..."
  pv -s ${SIZE}k ${FILE} \
  | tar zxf - -C ${VOLUME_PATH}
echo "DONE!"
echo "Ejecting..."
diskutil eject ${DISK}
