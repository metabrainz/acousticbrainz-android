#!/usr/bin/env bash
set -e
export PREFIX="$OUTDIR/$1"
if [ "$1" !=  "armeabi-v7a" ] && [ "$1" != "arm64-v8a" ] && [ "$1" == "x86" ] && [ "$1" == "x86_64" ]; then
  printf "Invalid input argument"
  exit 1
fi

./build_3rdparty_android.sh $1
cd ../essentia
./waf configure \
      --cross-compile-android --android-abi=$1 \
      --fft=KISS \
      --prefix=$PREFIX \
      --pkg-config-path=$PREFIX/lib/pkgconfig \
      --build-static
./waf install
./waf clean