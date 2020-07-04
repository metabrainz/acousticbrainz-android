#!/usr/bin/env bash
export NDK=/home/amcap1712/Android/Sdk/ndk/21.2.6472646

export PATH=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH
PWD="$(pwd)"

export OUTDIR="$PWD/../output"
echo $OUTDIR

./download_3rdparty.sh
./build_essentia.sh arm64-v8a
./build_essentia.sh x86_64
./build_essentia.sh x86
./build_essentia.sh armeabi-v7a