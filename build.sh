#!/bin/bash
case "$SHED_BUILD_MODE" in
    toolchain)
        ./configure --prefix=/tools || exit 1
        ;;
    *)
        sed -i 's/extras//' Makefile.in
        ./configure --prefix=/usr || exit 1
        ;;
esac
make -j $SHED_NUM_JOBS && \
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1
if [ "$SHED_BUILD_MODE" != 'toolchain' ]; then
    mkdir -pv "${SHED_FAKE_ROOT}/usr/share/doc/gawk-4.2.1"
    cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} "${SHED_FAKE_ROOT}/usr/share/doc/gawk-4.2.1"
fi
