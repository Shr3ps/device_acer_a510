#!/sbin/sh
# replace the above line with the path to your recovery's shell

# don't create LVM partitions if they already exist
# replace /dev/lvpool/system with an appropriate LV device from your
# setup
umount -l /system
[ -e /dev/lvpool/system ] && $(/lvm/sbin/lvm vgck -v) && $(mount /system) && $(umount -l /system) && exit 0

# Replace the commands below with the appropriate ones for your
# device from step 4

# format physical volumes
umount -l /system
/lvm/sbin/lvm lvremove -f /dev/lvpool/system
/lvm/sbin/lvm vgremove -f lvpool
/lvm/sbin/lvm pvremove -ff -y /dev/block/platform/sdhci-tegra.3/by-name/APP
umount -l /dev/block/platform/sdhci-tegra.3/by-name/APP
make_ext4fs /dev/block/platform/sdhci-tegra.3/by-name/APP
/lvm/sbin/lvm pvremove -ff -y /dev/block/platform/sdhci-tegra.3/by-name/FLX
umount -l /dev/block/platform/sdhci-tegra.3/by-name/FLX
make_ext4fs /dev/block/platform/sdhci-tegra.3/by-name/FLX

# create physical volumes
/lvm/sbin/lvm pvcreate /dev/block/platform/sdhci-tegra.3/by-name/APP /dev/block/platform/sdhci-tegra.3/by-name/FLX

# create the volume group
/lvm/sbin/lvm vgcreate lvpool /dev/block/platform/sdhci-tegra.3/by-name/APP /dev/block/platform/sdhci-tegra.3/by-name/FLX

# create logical volumes
/lvm/sbin/lvm lvcreate -L 688M -n system lvpool

# format logical volumes
umount -l /system
make_ext4fs /dev/lvpool/system

exit 0
