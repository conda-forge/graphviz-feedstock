set -e
env | sort

./configure --help || true
if [ `uname` == Darwin ]; then
    autoreconf -vfi
    ./configure \
        --with-quartz \
        --disable-silent-rules \
        --disable-dependency-tracking \
        --prefix=$PREFIX \
        --disable-debug \
        --disable-java \
        --disable-php \
        --disable-perl \
        --disable-tcl \
        --without-x \
        --without-qt \
        --without-gtk
else
    ./configure \
        --disable-silent-rules \
        --disable-dependency-tracking \
        --prefix=$PREFIX \
        --disable-debug \
        --disable-java \
        --disable-php \
        --disable-perl \
        --disable-tcl \
        --without-x \
        --without-qt \
        --without-gtk
fi

make -j${CPU_COUNT}
make install

# configure plugins
dot -c
