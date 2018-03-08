#!/bin/bash
case "$SHED_BUILDMODE" in
    toolchain)
        ./configure --prefix=/tools || exit 1
        ;;
    *)
        sed -i 's/extras//' Makefile.in
        ./configure --prefix=/usr || exit 1
        ;;
esac
make -j $SHED_NUMJOBS && \
make DESTDIR="$SHED_FAKEROOT" install || exit 1
if [ "$SHED_BUILDMODE" != 'toolchain' ]; then
    mkdir -pv "${SHED_FAKEROOT}/usr/share/doc/gawk-4.2.1"
    cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} "${SHED_FAKEROOT}/usr/share/doc/gawk-4.2.1"
fi
