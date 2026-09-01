#!/system/bin/sh
# Fix SD card after soft reboot with KernelSU
# Run before vold mounts storage (post-fs-data.d)

# Release stale block layer reference
echo mmc0:59b4 > /sys/bus/mmc/drivers/mmcblk/unbind
sleep 2

# Re-bind to simulate card re-insertion
echo mmc0:59b4 > /sys/bus/mmc/drivers/mmcblk/bind
sleep 3
