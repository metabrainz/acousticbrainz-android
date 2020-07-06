#!/bin/bash
set -e
echo "Building libyaml"

cd ../temp/libyaml

alias cmake-android='cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE'

cmake \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE \
    -DANDROID_PLATFORM=$ANDROID_API \
    -DANDROID_ABI=$ANDROID_ABI_CMAKE \
	.
make
make install
make clean
rm -f CMakeCache.txt