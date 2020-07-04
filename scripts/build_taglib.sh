#!/bin/bash
set -e
echo "Building taglib $TAGLIB_VERSION"

cd ../temp/$TAGLIB_VERSION

alias cmake-android='cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE'

cmake \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE \
    -DANDROID_PLATFORM=$ANDROID_API \
    -DANDROID_ABI=$ANDROID_ABI_CMAKE \
	. 
make
# patch taglib.cp (missing -lz flag)
sed -i 's/-ltag/-ltag -lz/g' taglib.pc
make install
make clean
rm -rf CMakeCache.txt

