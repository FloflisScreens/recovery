#!/bin/bash

adb shell dd if=/dev/block/bootdevice/by-name/recovery of=/sdcard/recovery.backup.${RANDOM}.img bs=2048
adb shell rm /sdcard/recovery.new.img && adb push recovery.new.img /sdcard/
adb shell dd if=/sdcard/recovery.new.img of=/dev/block/bootdevice/by-name/recovery bs=2048
adb reboot recovery
