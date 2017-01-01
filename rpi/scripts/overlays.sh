#!/bin/bash -xe

readonly OVERLAYS=$(
  find ./alpine-${MARK}/overlays \
    -type d \
    -name "${MARK}"
)

for overlay in $OVERLAYS; do
  pushd $overlay
    tar -zcf ../${MARK}.tar.gz ./*
  popd
done
