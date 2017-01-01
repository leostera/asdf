#!/bin/bash -e

readonly OVERLAYS=$(
  find ./alpine-${MARK}/overlays \
    -type d \
    -name "${MARK}"
)

for overlay in $OVERLAYS; do
  pushd $overlay
    SIZE=$( du -s . | cut -f 1)
    tar -zcf - ./* \
      | pv -s ${SIZE}k \
      > ../${MARK}.tar.gz
  popd
done
