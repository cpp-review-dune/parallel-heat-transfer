#!/usr/bin/env bash

DIR=$(pwd)/build
if [ -d "$DIR" ]; then
  printf '%s\n' "Removing Lock ($DIR)"
  rm -rf "$DIR"
fi

export BRAID_DIR=/usr/include/xbraid/

cmake \
  -S code-gallery/parallel_in_time \
  -B build \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_STANDARD=17 \
  -Wno-dev

cmake --build build
pushd build
./parallel_in_time | tee -a $(date -u +"%Y-%m-%d-%H-%M-%S" --date='5 hours ago').log
popd