#!/bin/bash
set -e
echo "Building lame $LAME_VERSION"

cd ../temp/lame-$LAME_VERSION

CPPFLAGS=-fPIC ./configure --prefix=$PREFIX \
    --enable-asm \
    --disable-fast-install \
    --disable-analyzer-hooks \
    --disable-gtktest \
    --disable-frontend \
    $SHARED_OR_STATIC \
    --host=$ANDROID_TARGET
make
make install
make clean