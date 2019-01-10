# Pris Recovery

Recovery hacking effort for the purposes of Pris project

## Dependencies

- JRE (for Gradle)
- Python


## Editing the image

Project root is in the `src` directory.

## Compiling the image

```
./build.sh
```

A file named `recovery.new.img` will be created.


## Flashing the image

First run on the PC:

```
adb push recovery.new.img /sdcard/recovery.img
```

Then run as root on the device:

```
dd if=/dev/block/bootdevice/by-name/recovery of=/sdcard/recovery-backup.img bs=2048
dd if=/sdcard/recovery.img of=/dev/block/bootdevice/by-name/recovery bs=2048
```

To restore, mount the partitions and run:

```
dd if=/sdcard/recovery-backup.img of=/dev/block/bootdevice/by-name/recovery bs=2048
```

## Signing the update packages / patches with the image keys

```
tools/stockerize/stockerize.sh package_root package.zip
```

The zips will be packed and signed with the same keys recovery was generated with.
