# Pris Recovery

Recovery hacking effort for the purposes of Pris project

## Dependencies

- JRE (for Gradle)
- Python


## Editing the image

Project root is in `tools/Android_boot_image_editor/build/unzip_boot/`.

## Ccompiling the image

```
cd tools/Android_boot_image_editor/
./gradlew pack
```

A file named `tools/Android_boot_image_editor/recovery.img.signed` will be created.


## Flashing the image

First run on the PC:

```
adb push tools/Android_boot_image_editor/recovery.img.signed /sdcard/recovery.img
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

## Signing the packages with the image keys

```
tools/stockerize/stockerize.sh package_root package.zip
```
