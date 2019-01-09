#!/bin/sh
rm -rf ./tools/Android_boot_image_editor/build/unzip_boot ./recovery.new.img
mkdir -p ./tools/Android_boot_image_editor/build/unzip_boot
cp -R ./src/* ./tools/Android_boot_image_editor/build/unzip_boot/
cd ./tools/Android_boot_image_editor
./gradlew pack
mv recovery.img.signed ../../recovery.new.img
echo 'Recovery created at recovery.new.img'
