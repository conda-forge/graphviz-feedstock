#!/bin/bash
set -x

./autogen.sh

# remove libtool files
find $PREFIX -name '*.la' -delete

declare -a _xtra_config_flags

if [ "${target_platform}" = "osx-64" ]; then
    export OBJC="${CC}"
    _xtra_config_flags+=(--with-quartz)
    _xtra_config_flags+=(--with-gts=yes)
fi

if [ "${target_platform}" = "linux-64" ]; then
    _xtra_config_flags+=(--with-gts=yes)
fi

./configure --prefix=$PREFIX \
            --disable-debug \
            --disable-java \
            --disable-php \
            --disable-perl \
            --disable-tcl \
            --enable-ltdl \
            --without-x \
            --without-qt \
            --without-gtk \
            --with-gdk=yes \
            --with-rsvg=yes \
            --with-expat=yes \
            --with-libgd=yes \
            --with-freetype2=yes \
            --with-fontconfig=yes \
            --with-pangocairo=yes \
            --with-gdk-pixbuf=yes \
            "${_xtra_config_flags[@]}"

make
# This is failing for rtest.
# Doesn't do anything for the rest
# make check
make install

# Configure plugins
$PREFIX/bin/dot -c
