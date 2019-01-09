#!/bin/sh

# Create a Nokia 8110 4G stock recovery compatible update.zip archive
# Requirements: JRE 6+, zip
# Usage: stockerize.sh [input_directory] [output.zip]

SCRIPTDIR="$(dirname "$(realpath "$0")")"
KEYDIR="$(realpath ${SCRIPTDIR}/../Android_boot_image_editor/security)"
TEMPDIR="$SCRIPTDIR/tmp"

mkdir -p "$TEMPDIR"
cp -r "$1"/* "$TEMPDIR"/
mkdir -p "$TEMPDIR/META-INF/com/google/android/" 
cp "$SCRIPTDIR/update-binary" "$TEMPDIR/META-INF/com/google/android/" 
pushd $TEMPDIR
zip -r update.zip .
popd
java -jar "$SCRIPTDIR/signapk.jar" -w "$KEYDIR/testkey.x509.pem" "$KEYDIR/testkey.pk8" "$TEMPDIR/update.zip" $2
rm -rf $TEMPDIR

echo "Signed archive created at $2"
