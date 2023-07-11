#!/usr/bin/env bash

DIR=$(pwd)/build
if [ -d "$DIR" ]; then
  printf '%s\n' "Removing Lock ($DIR)"
  rm -rf "$DIR" *.tar.zst
fi

export BRAID_DIR=/usr/include/xbraid/
# export OMP_PROC_BIND=true

TIME=$(date -u +"%Y-%m-%d-%H-%M-%S" --date='5 hours ago')

cmake \
  -S code-gallery/parallel_in_time \
  -B build \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_STANDARD=17 \
  -Wno-dev

cmake --build build
pushd build
./parallel_in_time | tee -a $TIME.log
popd
tar -c -I 'zstd -19 -T0' -f $TIME.tar.zst build
