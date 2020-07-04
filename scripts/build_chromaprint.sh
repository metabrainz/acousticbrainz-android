#!/bin/bash
set -e
echo "Building chromaprint $CHROMAPRINT_VERSION"

cd ../temp/chromaprint-v$CHROMAPRINT_VERSION

alias cmake-android='cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE'

cmake \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_TOOLS=OFF \
    -DFFMPEG_ROOT=$PREFIX \
    -DFFT_LIB=kissfft \
    -DKISSFFT_SOURCE_DIR="vendor/kissfft" \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE \
    -DANDROID_PLATFORM=$ANDROID_API \
    -DANDROID_ABI=$ANDROID_ABI_CMAKE \
    .

make
make install
make clean
rm -rf CMakeCahe.txt