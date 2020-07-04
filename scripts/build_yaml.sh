#!/bin/bash
set -e
echo "Building libyaml $LIBYAML_VERSION"

cd ../temp/$LIBYAML_VERSION
CFLAGS="-fPIC" ./configure \
    --prefix=$PREFIX \
    $SHARED_OR_STATIC \
    --host=$ANDROID_TARGET \
    --build=$ANDROID_BUILD_ARCH
make
make install

ln -s $PREFIX/lib/libyaml-0.so $PREFIX/lib/libyaml.so
