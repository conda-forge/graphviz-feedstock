#!/bin/bash
set -ex

mkdir build
cd build

cmake -G Ninja \
    -Denable_tcl=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    ..

cmake --build .
cmake --install .
