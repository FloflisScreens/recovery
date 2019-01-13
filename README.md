# Pris Recovery

Recovery hacking effort for the purposes of Pris project

## Dependencies

- ADB
- Bash
- JDK 8 (for Gradle)
- Python


## Editing the image

Project root is in the `src` directory.

## Compiling the image

```
make build
```

A file named `recovery-8110.img` will be created.


## Flashing the image

Acquire ADB root on the device and then run on the PC from the working directory (needs Bash):

```
make backup
make deploy
adb reboot recovery
```

To restore, mount the partitions and run:

```
mv works/backups/recovery.$RANDOMID.img ./recovery-8110.img
adb deploy
```

## Getting to the root shell in the recovery mode

The patched recovery includes Busybox-based root shell. To use it, run `adb shell`.


## Signing the update packages / patches with the image keys

```
tools/stockerize/stockerize.sh package_root package.zip
```

The zips will be packed and signed with the same keys recovery was generated with.
