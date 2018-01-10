#!/bin/bash
sed -i 's/extras//' Makefile.in
./configure --prefix=/usr || exit 1
make -j $SHED_NUMJOBS || exit 1
make DESTDIR="$SHED_FAKEROOT" install || exit 1
mkdir -pv ${SHED_FAKEROOT}/usr/share/doc/gawk-4.2.0
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} ${SHED_FAKEROOT}/usr/share/doc/gawk-4.2.0
