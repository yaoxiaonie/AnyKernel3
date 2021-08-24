# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=RainKernel by MistyRain
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=lithium
supported.versions=10
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel boot install
dump_boot;

## Add init.rain.rc
mount -o rw,remount -t auto /vendor > /dev/null;
mount -o rw,remount -t auto /system > /dev/null;
insert_line /vendor/etc/init/hw/init.qcom.rc "import /vendor/etc/init/hw/init.rain.rc" before "import /vendor/etc/init/hw/init.qcom.power.rc" "import /vendor/etc/init/hw/init.rain.rc";
cp -a /tmp/anykernel/patch/* /vendor/etc/init/hw/
set_perm_recursive 0 0 755 644 /vendor/etc/init/hw/*;


write_boot;
## end boot install


# shell variables
#block=vendor_boot;
#is_slot_device=1;
#ramdisk_compression=auto;

# reset for vendor_boot patching
#reset_ak;


## AnyKernel vendor_boot install
#split_boot; # skip unpack/repack ramdisk since we don't need vendor_ramdisk access

#flash_boot;
## end vendor_boot install

