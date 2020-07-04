#!/bin/bash
set -e
echo "Installing headers for Eigen $EIGEN_VERSION"

cd ../temp/eigen-eigen*

mkdir build
cd build

cmake ../ -DCMAKE_INSTALL_PREFIX=$PREFIX
make install
mkdir -p "$PREFIX"/lib/pkgconfig/
cp "$PREFIX"/share/pkgconfig/eigen3.pc "$PREFIX"/lib/pkgconfig/

cd ..
rm -rf build