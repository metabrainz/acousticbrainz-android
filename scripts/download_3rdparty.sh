#!/bin/bash
set -e
. ./build_config.sh

mkdir ../temp
cd ../temp

curl -SLO https://github.com/acoustid/chromaprint/releases/download/v$CHROMAPRINT_VERSION/chromaprint-$CHROMAPRINT_VERSION.tar.gz
curl -SLO https://bitbucket.org/eigen/eigen/get/$EIGEN_VERSION.tar.gz
curl -SL -o lame-$LAME_VERSION.tar.gz "http://downloads.sourceforge.net/project/lame/lame/$LAME_VERSION/lame-$LAME_VERSION.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flame%2F&ts=1476009914&use_mirror=ufpr"
curl -SLO https://ffmpeg.org/releases/$FFMPEG_VERSION.tar.gz
curl -SLO http://www.mega-nerd.com/SRC/$LIBSAMPLERATE_VERSION.tar.gz
curl -SLO http://taglib.github.io/releases/$TAGLIB_VERSION.tar.gz
curl -SLO http://pyyaml.org/download/libyaml/$LIBYAML_VERSION.tar.gz

tar -xf chromaprint-$CHROMAPRINT_VERSION.tar.gz
tar -xf $EIGEN_VERSION.tar.gz
tar -xf lame-$LAME_VERSION.tar.gz
tar -xf $FFMPEG_VERSION.tar.gz
tar -xf $LIBSAMPLERATE_VERSION.tar.gz
tar -xf $TAGLIB_VERSION.tar.gz
tar -xf $LIBYAML_VERSION.tar.gz
