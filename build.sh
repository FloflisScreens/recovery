#!/bin/sh
echo 'Populating symlinks...'
rm -rf ./src/root/system/bin
mkdir -p ./src/root/system/bin
for util in $(<bbutils.txt); do 
  ln -s /sbin/busybox ./src/root/system/bin/$util
done
chmod 0777 ./src/root/system/bin/*
echo 'Packing the image...'
rm -rf ./tools/Android_boot_image_editor/build/unzip_boot ./recovery.new.img
mkdir -p ./tools/Android_boot_image_editor/build/unzip_boot
cp -R ./src/* ./tools/Android_boot_image_editor/build/unzip_boot/
cd ./tools/Android_boot_image_editor
./gradlew pack
mv recovery.img.signed ../../recovery.new.img
echo 'Recovery created at recovery.new.img'
