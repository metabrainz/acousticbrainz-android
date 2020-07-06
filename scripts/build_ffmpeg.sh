#!/bin/bash
set -e
echo "Building FFmpeg $FFMPEG_VERSION"

if test "$1" = "--no-muxers"; then
    echo Building FFmpeg without muxers
    FFMPEG_AUDIO_FLAGS_MUXERS=""
fi

cd ../temp/$FFMPEG_VERSION

./configure \
    --enable-pic \
    --disable-asm \
    $FFMPEG_AUDIO_FLAGS \
    $FFMPEG_AUDIO_FLAGS_MUXERS \
    --prefix=$PREFIX \
    --extra-ldflags="-O3 -fPIC -L$PREFIX/lib/" \
    --extra-cflags="-I$PREFIX/include" \
    $SHARED_OR_STATIC \
    --enable-cross-compile \
    --arch=$ANDROID_ARCH \
    --target-os=android \
    --sysroot=$ANDROID_TOOLCHAIN/sysroot \
    --cc=$CC \
    --cross-prefix=$ANDROID_CROSS_PREFIX-
make
make install
make clean

