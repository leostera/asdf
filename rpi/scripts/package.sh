#!/bin/bash -e

readonly SIZE=$(
  du -s ./alpine-${MARK} \
    | cut -f 1
)

pushd alpine-${MARK}
  tar -zcf - ./* \
    | pv -s ${SIZE}k \
    > ../alpine-${MARK}.tar.gz
popd
