set -xou

NPROC=$CPU_COUNT
if [[ $(uname) == "Darwin" ]]; then
    export CFLAGS=-D__APPLE_USE_RFC_2292
fi

if [[ $(uname) == "Linux" ]]; then
    NPROC=$(nproc)
fi

./configure --prefix $PREFIX \
            --libdir ${PREFIX}/lib \
            --bindir ${PREFIX}/bin \
            --disable-qt5 \
            --disable-gtk3 \
            --disable-gdbm \
            --disable-python \
            --disable-mono

make -j${NPROC}
make install
