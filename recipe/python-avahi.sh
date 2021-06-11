#!/bin/bash

set -ex

mkdir -p _build_py${PYVER}
cd _build_py${PYVER}

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
make -j ${CPU_COUNT} -C avahi-python

# test
make -j ${CPU_COUNT} -C avahi-python check

# install
make -j ${CPU_COUNT} -C avahi-python install
