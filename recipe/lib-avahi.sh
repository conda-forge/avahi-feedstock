set -xou

EXTRA_DISABLES=""
NPROC=$CPU_COUNT
if [[ $(uname) == "Darwin" ]]; then
    export CFLAGS=-D__APPLE_USE_RFC_2292
    EXTRA_DISABLES="--disable-autoipd"
fi


./configure --prefix $PREFIX \
            --libdir ${PREFIX}/lib \
            --bindir ${PREFIX}/bin \
            --disable-qt5 \
            --disable-gtk3 \
            --disable-gdbm \
            --disable-python \
            --disable-mono $EXTRA_DISABLES

make -j${NPROC}
make install
make distclean
