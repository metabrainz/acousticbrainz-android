#!/bin/bash
set -e
echo "Building libsamplerate $LIBSAMPLERATE_VERSION"

cd ../temp/$LIBSAMPLERATE_VERSION

# Libsamplerate contains outdated config.sub and config.guess.
# Replace them with the newest version to make Android builds work.
git clone --depth=1 git://git.savannah.gnu.org/config.git
mv config/config.sub config/config.guess Cfg

CPPFLAGS=-fPIC ./configure \
    --prefix=$PREFIX \
    $LIBSAMPLERATE_FLAGS \
    --enable-static \
    --host=$ANDROID_TARGET
make
make install
make clean
rm -rf config Cfg/config.sub Cfg/config.guess