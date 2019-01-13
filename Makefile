# Project Pris/GerdaOS recovery makefile

# Common vars

PERSISTDIR = '/data/media/0'
INTERNALDEVICE = '/dev/block/bootdevice/by-name/userdata'
SHELL = '/bin/bash'
BUILDID = $(shell bash -c 'echo $$RANDOM')

TARGET = 8110

# Common tasks

all: build backup deploy

build: build-recovery

backup: backup-recovery

deploy: deploy-recovery

clean: clean-recovery

# Recovery image part

pre-build-recovery: clean-recovery
	$(shell mkdir -p src/${TARGET}/root/system/bin; for util in $$(<bbutils.txt); do ln -sf /sbin/busybox src/${TARGET}/root/system/bin/$$util; done)
	chmod -R 777 ./src/${TARGET}/root/system/bin/
	mkdir -p ./tools/Android_boot_image_editor/build/unzip_boot/
	cp -R ./src/${TARGET}/* ./tools/Android_boot_image_editor/build/unzip_boot/

build-recovery: pre-build-recovery
	cd ./tools/Android_boot_image_editor && ./gradlew pack && mv recovery.img.signed ../../recovery-${TARGET}.img
	echo 'Recovery image created at recovery-${TARGET}.img'

backup-recovery:
	adb shell mount -o nosuid,nodev,noatime,barrier=1,noauto_da_alloc,discard ${INTERNALDEVICE} /data
	adb shell dd of=${PERSISTDIR}/recovery.backup.img if=/dev/block/bootdevice/by-name/recovery bs=2048
	mkdir -p works/backups && adb pull ${PERSISTDIR}/recovery.backup.img works/backups/recovery.${BUILDID}.img
	adb shell rm -f ${PERSISTDIR}/recovery.backup.img
	echo "Recovery image backed up to works/backups/recovery.${BUILDID}.img"

deploy-recovery:
	adb shell mount -o nosuid,nodev,noatime,barrier=1,noauto_da_alloc,discard ${INTERNALDEVICE} /data
	adb push ./recovery-${TARGET}.img ${PERSISTDIR}/recovery.new.img
	adb shell dd if=${PERSISTDIR}/recovery.new.img of=/dev/block/bootdevice/by-name/recovery bs=2048
	adb shell rm ${PERSISTDIR}/recovery.new.img
	echo 'Recovery image deployed'

clean-recovery:
	rm -rf ./tools/Android_boot_image_editor/build/unzip_boot
	rm -rf ./src/${TARGET}/root/system/bin
	rm -f ./recovery-${TARGET}.img
