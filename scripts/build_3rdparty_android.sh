#!/bin/bash
set -e

. ./build_config.sh
. ./build_config_android.sh $1
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"

./build_libsamplerate.sh
./build_lame.sh
./build_ffmpeg.sh
./build_eigen3.sh
./build_taglib.sh
./build_chromaprint.sh
./build_yaml.sh
