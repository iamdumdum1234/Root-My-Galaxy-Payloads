# SD Card Soft Reboot Fix for Galaxy Tab S9 FE (SM-X510)

## Problem
After a soft reboot with KernelSU loaded, the SD card becomes `unmountable`
because the MMC block layer holds a stale reference. `vold` runs
`fsck.exfat_sec` which fails with exit code 8.

## Fix
The MMC card needs to be unbound and re-bound to release the stale
block layer reference.

## Installation

# Create directories
mkdir -p /data/adb/post-fs-data.d
mkdir -p /data/adb/service.d

# Copy scripts
cp fix_mmc.sh /data/adb/post-fs-data.d/fix_mmc.sh
cp fix_sdcard.sh /data/adb/service.d/fix_sdcard.sh

# Make executable
chmod 755 /data/adb/post-fs-data.d/fix_mmc.sh
chmod 755 /data/adb/service.d/fix_sdcard.sh

#How It Works
post-fs-data.d/fix_mmc.sh runs before vold mounts storage

Unbinds mmc0:59b4 from the mmcblk driver (releases stale reference)

Re-binds (re-initializes the block device)

vold's fsck.exfat_sec now succeeds and mounts the SD card

service.d/fix_sdcard.sh is a fallback that mounts via sm if vold fails

#Note
This is a workaround for KernelSU late-load + soft reboot on Samsung Exynos
devices. A full reboot does not require this fix.
