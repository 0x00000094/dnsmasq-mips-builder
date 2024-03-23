#!/bin/bash

[ -z $1 ] && exit 1
PACKAGE=$1

docker build -t buildenv-base -f Dockerfile-base .
mkdir -p $(pwd)/$PACKAGE/work

#e50
#docker build -t stretch-mipsel -f Dockerfile-mipsel .
#docker run --rm -v $(pwd)/$PACKAGE/work:/work -v $(pwd)/$PACKAGE/entrypoint.sh:/entrypoint.sh stretch-mipsel bash /entrypoint.sh

#e100, e200, e300, e1000, ugw3, ugw4, ugwxg
docker build -t stretch-mips -f Dockerfile-mips .
docker run --rm -v $(pwd)/$PACKAGE/work:/work -v $(pwd)/$PACKAGE/entrypoint.sh:/entrypoint.sh stretch-mips bash /entrypoint.sh

# ar x *.deb
# tar xvzf data.tar.xz
