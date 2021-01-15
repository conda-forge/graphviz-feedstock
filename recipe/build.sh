#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./libltdl/config
cp $BUILD_PREFIX/share/gnuconfig/config.* ./config

# remove libtool files
find $PREFIX -name '*.la' -delete

if [ `uname` == Darwin ]; then
    export OBJC="${CC}"

    ./configure --prefix=$PREFIX \
                --with-quartz \
                --disable-debug \
                --disable-java \
                --disable-php \
                --disable-perl \
                --disable-tcl \
                --without-x \
                --without-qt \
                --without-gtk
else
    ./configure --prefix=$PREFIX \
                --disable-debug \
                --disable-java \
                --disable-php \
                --disable-perl \
                --disable-tcl \
                --without-x \
                --without-qt \
                --without-gtk
fi

make
# This is failing for rtest.
# Doesn't do anything for the rest
# make check
make install

dot -c
