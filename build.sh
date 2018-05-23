#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Configure
SHED_PKG_LOCAL_PREFIX='/usr'
if [ -n "${SHED_PKG_LOCAL_OPTIONS[toolchain]}" ]; then
    SHED_PKG_LOCAL_PREFIX='/tools'
fi
SHED_PKG_LOCAL_DOCDIR=${SHED_PKG_LOCAL_PREFIX}/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION}
sed -i 's/extras//' Makefile.in &&
./configure --prefix=${SHED_PKG_LOCAL_PREFIX} &&

# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1

# Install Documentation
if [ -n "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    mkdir -pv "${SHED_FAKE_ROOT}${SHED_PKG_LOCAL_DOCDIR}" &&
    cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} "${SHED_FAKE_ROOT}${SHED_PKG_LOCAL_DOCDIR}"
fi
