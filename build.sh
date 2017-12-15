#!/bin/bash
./configure --prefix=/usr
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} install
mkdir -pv ${SHED_FAKEROOT}/usr/share/doc/gawk-4.1.4
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} ${SHED_FAKEROOT}/usr/share/doc/gawk-4.1.4
