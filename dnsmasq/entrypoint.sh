#!/bin/bash
cd /
git config --global http.sslverify false
git clone http://thekelleys.org.uk/git/dnsmasq.git
cd dnsmasq
git checkout tags/v2.90

#COPTS="-DHAVE_IDN" DEB_BUILD_OPTIONS="noidn nodoc" \
#dpkg-buildpackage -d --target-arch $ARCH -T binary-arch

make all-i18n 
mkdir -p /work/dnsmasq && cp src/dnsmasq /work/dnsmasq