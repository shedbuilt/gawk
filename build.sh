#!/bin/bash
case "$SHED_BUILDMODE" in
    toolchain)
        ./configure --prefix=/tools || return 1
        ;;
    *)
        sed -i 's/extras//' Makefile.in
        ./configure --prefix=/usr || return 1
        ;;
esac

make -j $SHED_NUMJOBS || return 1
make DESTDIR="$SHED_FAKEROOT" install || return 1

if [ "$SHED_BUILDMODE" != 'toolchain' ]; then
    mkdir -pv ${SHED_FAKEROOT}/usr/share/doc/gawk-4.2.0
    cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} ${SHED_FAKEROOT}/usr/share/doc/gawk-4.2.0
fi
