#!/system/bin/sh
# Fallback: mount SD card if vold didn't do it
/data/local/tmp/fix_mmc.sh
sleep 2
sm mount public:179,1
