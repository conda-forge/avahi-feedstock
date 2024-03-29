#!/usr/bin/env bash

set -x

# update config.sub and config.guess
cp ${BUILD_PREFIX}/share/gnuconfig/config.* ${SRC_DIR}/

mkdir build
pushd build

EXTRA_DISABLES=""
if [[ $(uname) == "Darwin" ]]; then
    export CFLAGS="${CFLAGS} -D__APPLE_USE_RFC_2292"
    EXTRA_DISABLES="${EXTRA_DISABLES} --disable-autoipd"
fi

# configure
${SRC_DIR}/configure \
    --prefix=$PREFIX \
    --libdir=${PREFIX}/lib \
    --bindir=${PREFIX}/bin \
    --with-distro=none \
    --disable-qt3 \
    --disable-qt5 \
    --disable-gtk3 \
    --disable-gdbm \
    --disable-python \
    --disable-mono \
    ${EXTRA_DISABLES} \
;

# build
make -j ${CPU_COUNT} V=1 VERBOSE=1

# test (not when cross compiling)
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    make -j ${CPU_COUNT} V=1 VERBOSE=1 check
fi

make -j ${CPU_COUNT} V=1 VERBOSE=1 install
