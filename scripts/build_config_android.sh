#!/bin/bash
export ANDROID_NDK=/home/amcap1712/Android/Sdk/ndk/21.2.6472646
# Path to NDK
export PATH=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH
ANDROID_BUILD_ARCH=x86_64
# The CPU architecture of the NDK build tools (only x86_64 is available).
# Available platforms: https://developer.android.com/ndk/downloads

ANDROID_API=21
# Target Android API version.
# See https://developer.android.com/ndk/guides/cmake#android_platform
# API 21: Android 5.0 Lollipop.

# ANDROID_ARCH
# Required by FFmpeg. Target architecture:
# - arm
# - aarch64
# - i686
# - x86_64

# ANDROID_ABI_CMAKE
# Required by CMake. Target Android ABI:
# - armeabi-v7a
# - armeabi-v7a with NEON
# - arm64-v8a
# - x86
# - x86_64
# See https://developer.android.com/ndk/guides/cmake#android_abi

# ANDROID_TARGET
# Requiered by Autoconf. Target Android canonical triplet:
# - aarch64-linux-android
# - armv7a-linux-androideabi
# - i686-linux-android
# - x86_64-linux-android

if [ "$1" == "armeabi-v7a" ]; then
    ANDROID_ARCH=arm
    ANDROID_ABI_CMAKE=armeabi-v7a
    ANDROID_TARGET=armv7a-linux-androideabi
elif [ "$1" == "arm64-v8a" ]; then
    ANDROID_ARCH=aarch64
    ANDROID_ABI_CMAKE=arm64-v8a
    ANDROID_TARGET=aarch64-linux-android
elif [ "$1" == "x86" ]; then
    ANDROID_ARCH=i686
    ANDROID_ABI_CMAKE=x86
    ANDROID_TARGET=i686-linux-android
elif [ "$1" == "x86_64" ]; then
    ANDROID_ARCH=x86_64
    ANDROID_ABI_CMAKE=x86_64
    ANDROID_TARGET=x86_64-linux-android
else
    printf "Invalid input argument"
    exit 1
fi

export ANDROID_ARCH
export ANDROID_ABI_CMAKE
export ANDROID_TARGET
export ANDROID_TARGET_BINUTILS=$(echo $ANDROID_TARGET | sed "s/armv7a/arm/")
# Required for Autoconf. For 32-bit ARM (armv7a), binutils tools are prefixed with 'arm'.

export ANDROID_TOOLCHAIN=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-$ANDROID_BUILD_ARCH
export ANDROID_TOOLCHAIN_CMAKE=$ANDROID_NDK/build/cmake/android.toolchain.cmake
export ANDROID_CROSS_PREFIX=$ANDROID_TOOLCHAIN/bin/$ANDROID_TARGET_BINUTILS

export CC=$ANDROID_TOOLCHAIN/bin/$ANDROID_TARGET$ANDROID_API-clang
export CXX=$ANDROID_TOOLCHAIN/bin/$ANDROID_TARGET$ANDROID_API-clang++

export AR=$ANDROID_CROSS_PREFIX-ar
export AS=$ANDROID_CROSS_PREFIX-as
export NM=$ANDROID_CROSS_PREFIX-nm
export LD=$ANDROID_CROSS_PREFIX-ld
export RANLIB=$ANDROID_CROSS_PREFIX-ranlib
export STRIP=$ANDROID_CROSS_PREFIX-strip

# This will overwrite the value from build_config.sh
export SHARED_OR_STATIC="
--disable-shared \
--enable-static
"