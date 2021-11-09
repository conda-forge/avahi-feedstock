#!/bin/bash

set -ex

mkdir -p _build_py${PY_VER}
cd _build_py${PY_VER}

${SRC_DIR}/configure \
	--disable-autoipd \
	--disable-gdbm \
	--disable-glib \
	--disable-gobject \
	--disable-gtk \
	--disable-gtk3 \
	--disable-libdaemon \
	--disable-libevent \
	--disable-manpages \
	--disable-mono \
	--disable-qt3 \
	--disable-qt4 \
	--disable-qt5 \
	--enable-dbus \
	--enable-python \
	--enable-python-dbus \
	--enable-pygobject \
	--prefix=${PREFIX} \
	--with-xml=expat \
;

# build
make -j ${CPU_COUNT} V=1 VERBOSE=1 -C avahi-python

# test
if [[ "${build_platform}" == "${target_platform}" ]]; then
	make -j ${CPU_COUNT} V=1 VERBOSE=1 -C avahi-python check
fi

# install
make -j ${CPU_COUNT} V=1 VERBOSE=1 -C avahi-python install
